//
//  ViewController.m
//  MChatCardEnc
//
//  Created by Gantulga Ts on 11/10/20.
//

#import "ViewController.h"
#import "NSData+Encryption.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *encryptedLabel;

@end

@implementation ViewController

// MARK: -
// MARK: === UIViewController ===

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)generateButtonClicked:(id)sender {
    NSString *number = [self.cardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *encryptedString = [[number dataUsingEncoding:NSUTF8StringEncoding] encryptPKCS1ForTokenEx];;
    self.encryptedLabel.text = encryptedString;
    NSLog(@"encryptedString %@", encryptedString);
}

@end
