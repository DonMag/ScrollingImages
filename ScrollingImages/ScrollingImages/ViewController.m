//
//  ViewController.m
//  ScrollingImages
//
//  Created by Don Mag on 7/19/18.
//  Copyright © 2018 DonMag. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *theScrollView;

@end

@implementation ViewController

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	
	// execute before rotation
	
	// get the "index" of the current image in the scroll view
	NSUInteger idx = (unsigned)(_theScrollView.contentOffset.x / _theScrollView.frame.size.width);
	
	[coordinator animateAlongsideTransition:^(id  _Nonnull context) {
		// execute during rotation
		
		// update the scroll view's contentOffset, based on the "index"
		self.theScrollView.contentOffset = CGPointMake(idx * self.theScrollView.frame.size.width, 0);
		
	} completion:^(id  _Nonnull context) {
		// execute after rotation (if additional code wanted)
	}];

}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSArray *images = @[@"a", @"b", @"c", @"d", @"e"];
	
	[_theScrollView setPagingEnabled:YES];
	[_theScrollView setAlwaysBounceVertical:NO];
	[_theScrollView setAlwaysBounceHorizontal:NO];
	
	// we'll use this to hold the most recently added view
	UIImageView *prevImageView = nil;
	
	for (int i = 0; i < images.count; i++) {

		// create an image view with named image from array
		UIImageView *v = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];

		// we want to use auto-layout
		v.translatesAutoresizingMaskIntoConstraints = NO;
		
		// we want aspect-fit
		v.contentMode = UIViewContentModeScaleAspectFit;

		// add it to the scroll view
		[_theScrollView addSubview:v];
		
		// set width and height constraints equal to the scroll view
		[[NSLayoutConstraint
		  constraintWithItem:v
		  attribute:NSLayoutAttributeWidth
		  relatedBy:NSLayoutRelationEqual
		  toItem:_theScrollView
		  attribute:NSLayoutAttributeWidth
		  multiplier:1.0
		  constant:0.0] setActive:YES];

		[[NSLayoutConstraint
		  constraintWithItem:v
		  attribute:NSLayoutAttributeHeight
		  relatedBy:NSLayoutRelationEqual
		  toItem:_theScrollView
		  attribute:NSLayoutAttributeHeight
		  multiplier:1.0
		  constant:0.0] setActive:YES];
		
		if (i == 0) {  // if it's the first image
			
			// add top constraint
			[[NSLayoutConstraint
			  constraintWithItem:v
			  attribute:NSLayoutAttributeTop
			  relatedBy:NSLayoutRelationEqual
			  toItem:_theScrollView
			  attribute:NSLayoutAttributeTop
			  multiplier:1.0
			  constant:0.0] setActive:YES];
			
			// and leading constraint
			[[NSLayoutConstraint
			  constraintWithItem:v
			  attribute:NSLayoutAttributeLeading
			  relatedBy:NSLayoutRelationEqual
			  toItem:_theScrollView
			  attribute:NSLayoutAttributeLeading
			  multiplier:1.0
			  constant:0.0] setActive:YES];
			
		} else {
			
			// constrain leading to previous image view trailing
			[[NSLayoutConstraint
			  constraintWithItem:v
			  attribute:NSLayoutAttributeLeading
			  relatedBy:NSLayoutRelationEqual
			  toItem:prevImageView
			  attribute:NSLayoutAttributeTrailing
			  multiplier:1.0
			  constant:0.0] setActive:YES];

			// and top to previous image view top
			[[NSLayoutConstraint
			  constraintWithItem:v
			  attribute:NSLayoutAttributeTop
			  relatedBy:NSLayoutRelationEqual
			  toItem:prevImageView
			  attribute:NSLayoutAttributeTop
			  multiplier:1.0
			  constant:0.0] setActive:YES];
			
		}

		if (i == images.count - 1) {  // if it's the last image
			
			// add trailing constraint
			[[NSLayoutConstraint
			  constraintWithItem:v
			  attribute:NSLayoutAttributeTrailing
			  relatedBy:NSLayoutRelationEqual
			  toItem:_theScrollView
			  attribute:NSLayoutAttributeTrailing
			  multiplier:1.0
			  constant:0.0] setActive:YES];
			
			// and bottom constraint
			[[NSLayoutConstraint
			  constraintWithItem:v
			  attribute:NSLayoutAttributeBottom
			  relatedBy:NSLayoutRelationEqual
			  toItem:_theScrollView
			  attribute:NSLayoutAttributeBottom
			  multiplier:1.0
			  constant:0.0] setActive:YES];
			
		}

		// reference to most recently added view
		prevImageView = v;
		
	}
	
}

@end
