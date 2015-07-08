import MZFormSheetController

func presentMZFormSheet(size: CGSize, vc: UIViewController) {
  var formMZ = MZFormSheetController(size: size, viewController: vc)
  formMZ.transitionStyle = MZFormSheetTransitionStyle.SlideFromTop
  formMZ.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppears.MoveToTop
  formMZ.cornerRadius = 3.0
  formMZ.portraitTopInset = 150.0
  formMZ.shadowOpacity = 0.5
  formMZ.shouldDismissOnBackgroundViewTap = true
  formMZ.presentAnimated(true, completionHandler: nil)
}