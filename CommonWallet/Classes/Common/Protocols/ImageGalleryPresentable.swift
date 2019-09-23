import Foundation

protocol ImageGalleryDelegate: class {
    func didCompleteImageSelection(from gallery: ImageGalleryPresentable, with selectedImages: [UIImage])
    func didCompleteImageSelection(from gallery: ImageGalleryPresentable, with error: Error)
}

enum ImageGalleryPresentableError: Error {
    case accessDeniedPreviously
    case accessDeniedNow
    case accessRestricted
    case unknownAuthorizationStatus
}

protocol ImageGalleryPresentable: class {
    func presentImageGallery(from view: ControllerBackedProtocol?, delegate: ImageGalleryDelegate)
}
