# ScrollLabelView

ScrollLabelView is scroll label UIView.

## Requirements

- iOS7.1+

## Install

Include the PasswordDialogViewController class in your project.

## Usage

### Swift

Bridging header file.

``` objective-c
#import "ScrollLabelView.h"
```

``` swift
@IBOutlet weak var scrollLabelView: ScrollLabelView!

override func viewDidLoad() {
    super.viewDidLoad()
    
    // initialize
    self.scrollLabelView.text = "25/12/2015 00:00:00"
    self.scrollLabelView.flashText = "During synchronization"
    self.scrollLabelView.begin({() -> Void in
    })
    
    // start sync...
}

func didFinishSync() {
    self.scrollLabelView.text = "a minutes ago"
    self.scrollLabelView.finish({() -> Void in
    })
}
```

## License

This ScrollLabelView is released under the MIT License.
See [LICENSE](/LICENSE) for details.
