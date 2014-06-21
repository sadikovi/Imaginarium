//
//  ImaginariumViewController.m
//  Imaginarium
//
//  Created by Ivan Sadikov on 21/06/14.
//  Copyright (c) 2014 Ivan Sadikov. All rights reserved.
//

#import "ImaginariumViewController.h"
#import "ImageViewController.h"

@interface ImaginariumViewController ()

@end

@implementation ImaginariumViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        [ivc setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.apple.com/v/iphone-5s/gallery/b/images/download/%@.jpg", segue.identifier]]];
        ivc.title = segue.identifier;
    }
}

@end
