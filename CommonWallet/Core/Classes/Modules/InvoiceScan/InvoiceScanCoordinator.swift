/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import Photos

final class InvoiceScanCoordinator: NSObject {
    private weak var galleryDelegate: ImageGalleryDelegate?

    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    private func presentGallery(from view: ControllerBackedProtocol?,
                                delegate: ImageGalleryDelegate) {
        galleryDelegate = delegate

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        view?.controller.present(imagePicker,
                                 animated: true,
                                 completion: nil)
    }
}

extension InvoiceScanCoordinator: InvoiceScanCoordinatorProtocol {
    func process(payload: TransferPayload) {
        guard let view = TransferAssembly.assembleView(with: resolver, payload: payload) else {
            return
        }

        resolver.navigation?.push(view.controller)
    }

    func presentImageGallery(from view: ControllerBackedProtocol?, delegate: ImageGalleryDelegate) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                DispatchQueue.main.async {
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        self.presentGallery(from: view, delegate: delegate)
                    } else {
                        delegate.didFail(in: self, with: ImageGalleryError.accessDeniedNow)
                    }
                }
            })
        case .restricted:
            delegate.didFail(in: self, with: ImageGalleryError.accessRestricted)
        case .denied:
            delegate.didFail(in: self, with: ImageGalleryError.accessDeniedPreviously)
        default:
            presentGallery(from: view, delegate: delegate)
        }
    }
}

extension InvoiceScanCoordinator: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            galleryDelegate?.didCompleteImageSelection(from: self, with: [originalImage])
        } else {
            galleryDelegate?.didCompleteImageSelection(from: self, with: [])
        }

        galleryDelegate = nil

        picker.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        galleryDelegate?.didCompleteImageSelection(from: self, with: [])

        galleryDelegate = nil

        picker.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
