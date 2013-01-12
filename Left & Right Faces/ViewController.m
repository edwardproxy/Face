//
//  ViewController.m
//  Left & Right Faces
//
//  Created by Edward Sun on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
//#import "OpenSdk/MsfOpenSdkInterface.h"
//#import "OpenApi.h"


@implementation ViewController

@synthesize switchButton;
@synthesize flashButton;
@synthesize snapButton;
@synthesize redoButton;
@synthesize saveButton;
@synthesize segControl;
@synthesize toolBar;
@synthesize imagePicker;
@synthesize imageView;
@synthesize dict;
@synthesize leftImage;
@synthesize rightImage;
@synthesize orgImage;
@synthesize bOrg;
@synthesize bLeft;
@synthesize bRight;

@synthesize bannerContainerView;
@synthesize bannerView;

@synthesize appKey;
@synthesize appSecret;
@synthesize tokenKey;
@synthesize tokenSecret;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.showsCameraControls = NO;
        self.imagePicker.navigationBarHidden = YES;
        self.imagePicker.toolbarHidden = YES;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;    
        self.imagePicker.cameraOverlayView = self.view;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.imagePicker.cameraViewTransform = transform;
        self.imageView.transform = transform;
        
        self.flashButton.title = @"AUTO";
        [self.redoButton setEnabled:NO];
        [self.saveButton setEnabled:NO];
        [self.segControl setHidden:YES];
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Create a view of the standard size at the bottom of the screen.
    self.bannerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0,
                                                                       386.0,
                                                                       GAD_SIZE_320x50.width,
                                                                        GAD_SIZE_320x50.height)];
//    self.bannerView = [[GADBannerView alloc]
//                       initWithFrame:CGRectMake(0.0,
//                                                386.0,
//                                                GAD_SIZE_320x50.width,
//                                                GAD_SIZE_320x50.height)];
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,
                                                                      0,
                                                                      GAD_SIZE_320x50.width,
                                                                      GAD_SIZE_320x50.height)];
    
    self.bannerView.adUnitID = @"a14f02d98086a14";
    
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self.imagePicker;
//    [self.imagePicker.view addSubview:self.bannerView];
    [self.imagePicker.view addSubview:self.bannerContainerView];
    [self.bannerContainerView addSubview:self.bannerView];
//    [self.imagePicker.view bringSubviewToFront:self.bannerContainerView];
    
    [self.bannerView loadRequest:[GADRequest request]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.switchButton = nil;
    self.flashButton = nil;
    self.snapButton = nil;
    self.redoButton = nil;
    self.saveButton = nil;
    self.segControl = nil;
    self.toolBar = nil;
    self.imagePicker = nil;
    self.imageView = nil;
    self.dict = nil;
    self.leftImage = nil;
    self.rightImage = nil;
    self.orgImage = nil;
    
    self.bannerView = nil;
    self.bannerContainerView = nil;
    
    self.appKey = nil;
    self.appSecret = nil;
    self.tokenSecret = nil;
    self.tokenKey = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self presentModalViewController:self.imagePicker animated:NO];
    [self presentViewController:self.imagePicker animated:NO completion:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Functions

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //NSLog(@"imagePickerFunction");
    self.dict = info;
    UIImage *image = [self.dict valueForKey:UIImagePickerControllerOriginalImage];
    if (self.imagePicker.cameraDevice==UIImagePickerControllerCameraDeviceFront) {
        image = [UIImage imageWithCGImage:image.CGImage 
                                    scale:1.0 
                              orientation:UIImageOrientationLeftMirrored];
    }
    self.orgImage = image;
    self.imageView.image = self.orgImage;
    [self.imageView setHidden:NO];
    [self.view bringSubviewToFront:self.toolBar];
    [self.view bringSubviewToFront:self.segControl];
    [self.snapButton setEnabled:NO];
    [self.redoButton setEnabled:YES];
    [self.saveButton setEnabled:YES];
    [self.flashButton setEnabled:NO];
    [self.switchButton setEnabled:NO];
    [self.segControl setHidden:NO];
    [self.segControl setSelectedSegmentIndex:1];
    self.bLeft = NO;
    self.bRight = NO;
    self.bOrg = YES;
    //NSLog(@"imagePickerFunctionDone");
}

- (IBAction)takePhoto:(id)sender
{
    //NSLog(@"takePhoto");
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight ||
        [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {        
        return;
    } 
    
    [self.imagePicker takePicture];
}

- (IBAction)savePhoto:(id)sender
{
    UIImage *image = self.imageView.image;
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Photo Saved"];
    [dialog setMessage:@"Photo Saved\nHope you enjoy it"];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
}

- (IBAction)redoPhoto:(id)sender
{
    //NSLog(@"redo");
    [self.imageView setHidden:YES];
    [self.snapButton setEnabled:YES];
    [self.redoButton setEnabled:NO];
    [self.saveButton setEnabled:NO];
    [self.flashButton setEnabled:YES];
    [self.switchButton setEnabled:YES];
    [self.segControl setHidden:YES];
    self.leftImage = nil;
    self.rightImage = nil;
    self.orgImage = nil;
    self.dict = nil;
}

- (IBAction)swithFlash:(id)sender
{
    switch (self.imagePicker.cameraDevice) {
        case UIImagePickerControllerCameraDeviceRear:
            if (NO==[UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
                return;
            }
            break;
        case UIImagePickerControllerCameraDeviceFront:
            if (NO==[UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront]) {
                return;
            }
            break;    
        default:
            break;
    }
    
    switch (self.imagePicker.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeOff:
            self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            self.flashButton.title = @"ON";
            break;
        case UIImagePickerControllerCameraFlashModeOn:
            self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            self.flashButton.title = @"AUTO";
            break;
        case UIImagePickerControllerCameraFlashModeAuto:
            self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            self.flashButton.title = @"OFF";
            break;
        default:
            break;
    }

}

- (IBAction)swithCamera:(id)sender
{
    if (UIImagePickerControllerCameraDeviceFront==self.imagePicker.cameraDevice) {
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        return;
    }
    self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
}

- (void)showLeft
{   
    if (self.leftImage == nil) {
        UIImage *image = [self.dict valueForKey:UIImagePickerControllerOriginalImage];
//        CGSize size = image.size;
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = 0;
        CGFloat height = 0;
        UIImage *image1 = nil;
        UIImage *image2 = nil;
        if (self.imagePicker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
            CGSize size = image.size;
//            NSLog(@"size.w: %f", size.width);
//            NSLog(@"size.h: %f", size.height);
            if (size.width == 960) {
                width = 1280;
                height = 480;
            } else {
                width = 640;
                height = 240;
            }
            
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], 
                                                               CGRectMake(x, y, width, height));
            image1 = [UIImage imageWithCGImage:imageRef];
            image1 = [UIImage imageWithCGImage:image1.CGImage
                                         scale:1.0
                                   orientation:UIImageOrientationLeftMirrored];
            image2 = [UIImage imageWithCGImage:image1.CGImage
                                         scale:1.0
                                   orientation:UIImageOrientationRight];
            
            CGImageRelease(imageRef);
        }
        else
        {
            if (image.size.height < 1000) {
                width = 960;
                height = 360;
                
                CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], 
                                                                   CGRectMake(x, y, width, height));
                image1 = [UIImage imageWithCGImage:imageRef];
                image1 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:1.0
                                       orientation:UIImageOrientationLeftMirrored];
                image2 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:1.0
                                       orientation:UIImageOrientationRight];
                
                CGImageRelease(imageRef);
            }
            else {
                width = 2448 / 4;
                height = 3264 / 4;
                CGSize newSize = CGSizeMake(width, height);
                UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
                [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
                UIImage *small = UIGraphicsGetImageFromCurrentImageContext();    
                UIGraphicsEndImageContext();
                
                CGImageRef imageRef = CGImageCreateWithImageInRect([small CGImage], CGRectMake(0,
                                                                                               0,
                                                                                               small.size.width, 
                                                                                               small.size.height * 2));
                image1 = [UIImage imageWithCGImage:imageRef];
                image1 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:image1.scale
                                       orientation:UIImageOrientationUp];
                image2 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:image1.scale
                                       orientation:UIImageOrientationUpMirrored];
                
                CGImageRelease(imageRef);
                image = small;
            }
        }
        
        CGSize imageSize = image.size;
        if (NULL != UIGraphicsBeginImageContextWithOptions)
            UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        else
            UIGraphicsBeginImageContext(imageSize);    
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        [image1 drawInRect:CGRectMake(0, 0, imageSize.width/2, imageSize.height)];
        [image2 drawInRect:CGRectMake(imageSize.width/2, 0, imageSize.width/2, imageSize.height)];
        UIGraphicsPopContext();
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();        
        self.leftImage = screenshot;
        
        //UIGraphicsEndImageContext();
        CGContextRelease(context);
        
//        self.leftImage = image1;
    }
        
    self.imageView.image = self.leftImage;
    self.bLeft = YES;
    self.bRight = NO;
    self.bOrg = NO;
}

- (void)showRight
{
    //NSLog(@"showRight");
    if (self.rightImage == nil) {
        UIImage *image = [self.dict valueForKey:UIImagePickerControllerOriginalImage];
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = 0;
        CGFloat height = 0;
        UIImage *image1 = nil;
        UIImage *image2 = nil;
        if (self.imagePicker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
            CGSize size = image.size;
//            NSLog(@"size.w: %f", size.width);
//            NSLog(@"size.h: %f", size.height);
            if (size.width == 960) {
                width = 1280;
                height = 480;
                y = 480;
            } else {
                width = 640;
                height = 240;
                y = 240;
            }
//            y = 240;
//            width = 640;
//            height = 240;
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],
                                                               CGRectMake(x, y, width, height));
            image1 = [UIImage imageWithCGImage:imageRef];
            image1 = [UIImage imageWithCGImage:image1.CGImage
                                         scale:1.0
                                   orientation:UIImageOrientationLeftMirrored];
            image2 = [UIImage imageWithCGImage:image1.CGImage
                                         scale:1.0
                                   orientation:UIImageOrientationRight];
            
            CGImageRelease(imageRef);
        }
        else
        {
            if (image.size.height < 1000) {
                y = 360;
                width = 960;
                height = 360;
                CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], 
                                                                   CGRectMake(x, y, width, height));
                image1 = [UIImage imageWithCGImage:imageRef];
                image1 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:1.0
                                       orientation:UIImageOrientationLeftMirrored];
                image2 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:1.0
                                       orientation:UIImageOrientationRight];
                
                CGImageRelease(imageRef);

            }
            else {
                width = 2448 / 4;
                height = 3264 / 4;
                CGSize newSize = CGSizeMake(width, height);
                UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
                [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
                UIImage *small = UIGraphicsGetImageFromCurrentImageContext();    
                UIGraphicsEndImageContext();
                
                CGImageRef imageRef = CGImageCreateWithImageInRect([small CGImage], CGRectMake(width,
                                                                                               0,
                                                                                               small.size.width, 
                                                                                               small.size.height * 2));
                image1 = [UIImage imageWithCGImage:imageRef];
                image1 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:image1.scale
                                       orientation:UIImageOrientationUp];
                image2 = [UIImage imageWithCGImage:image1.CGImage
                                             scale:image1.scale
                                       orientation:UIImageOrientationUpMirrored];
                
                CGImageRelease(imageRef);
                image = small;
            }
        }
        
        //    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
        CGSize imageSize = image.size;
        if (NULL != UIGraphicsBeginImageContextWithOptions)
            UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        else
            UIGraphicsBeginImageContext(imageSize);    
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        [image1 drawInRect:CGRectMake(imageSize.width/2, 0, imageSize.width/2, imageSize.height)];
        [image2 drawInRect:CGRectMake(0, 0, imageSize.width/2, imageSize.height)];
        UIGraphicsPopContext();
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        self.rightImage = screenshot;
        
        //UIGraphicsEndImageContext();
        CGContextRelease(context);
        //NSLog(@"showRightDone");
        
//        self.imageView.image = image1;
    }
    
    self.imageView.image = self.rightImage;
    self.bLeft = NO;
    self.bRight = YES;
    self.bOrg = NO;
}

- (void)showOrg
{
//    self.dict = info;
//    UIImage *image = [self.dict valueForKey:UIImagePickerControllerOriginalImage];
//    if (self.imagePicker.cameraDevice==UIImagePickerControllerCameraDeviceFront) {
//        image = [UIImage imageWithCGImage:image.CGImage 
//                                    scale:1.0 
//                              orientation:UIImageOrientationLeftMirrored];
//    }
//    self.orgImage = image;
    self.imageView.image = self.orgImage;
    
    self.bLeft = NO;
    self.bRight = NO;
    self.bOrg = YES;
}

- (IBAction)segValueChanged:(id)sender
{
    switch ([self.segControl selectedSegmentIndex]) {
        case 0:
            [self showLeft];
            break;
        case 1:
            [self showOrg];
            break;
        case 2:
            [self showRight];
            break;
            
        default:
            break;
    }
}

#pragma mark - Admob Delegate

//- (void)adViewDidDismissScreen:(GADBannerView *)adView
//{
//    NSLog(@"delegate");
//}
//- (void)adViewDidReceiveAd:(GADBannerView *)view
//{
//    NSLog(@"delegate");
//}
//- (void)adView:(GADBannerView *)view
//didFailToReceiveAdWithError:(GADRequestError *)error
//{
//    NSLog(@"delegate");
//}
- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    NSLog(@"delegate");
}
- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
//    NSLog(@"delegate");
}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView
{
//    NSLog(@"delegate");
}

@end
