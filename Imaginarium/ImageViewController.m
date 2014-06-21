//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Ivan Sadikov on 21/06/14.
//  Copyright (c) 2014 Ivan Sadikov. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ImageViewController

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.1;
    _scrollView.maximumZoomScale = 1.2;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (UIImageView *)imageView {
    if (!_imageView)
        _imageView = [[UIImageView alloc] init];
    
    return _imageView;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    self.scrollView.zoomScale = 0.1;
    [self.spinner stopAnimating];
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self startDownloadingImage];
}

- (void)startDownloadingImage {
    self.image = nil;
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (!error) {
                                       if ([request.URL isEqual:self.imageURL]) {
                                           UIImage *image = [UIImage imageWithData:data];
                                           self.image = image;
                                       }
                                   }
                               }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
