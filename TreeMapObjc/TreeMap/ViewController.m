//
//  ViewController.m
//  TreeMap
//
//  Created by Jonathan Kopp on 10/29/20.
//

#import "ViewController.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Start treemap creation
    NSArray *values = [self getRandomData:20];
    [self generateSquares:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
                    values:values];
}
/// Creates a treemap based on values and frame passed in
- (void)generateSquares:(CGRect)rect values:(NSArray *)values {
    if (values.count <= 1) {
        // Create square view and add tap recognizer
        UIView* square = [[UIView alloc]init];
        square.frame = rect;
        square.backgroundColor = [self getRandomColor];
        square.tag = [values[0]integerValue];
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(squareTapped:)];
        [square addGestureRecognizer:tap];
        [self.view addSubview: square];
        return;
    }
    // Get sum of all values in array
    CGFloat sum = 0.0;
    for (NSInteger i = 0; i < values.count; i++) {
        sum += [values[i]floatValue];
    }
    // Find half the sum of array
    CGFloat half = sum / 2.0;
    // Find middle index based on half the sum of array
    NSInteger midIndex = values.count - 1;
    CGFloat midCounter = 0.0;
    CGFloat firstTotal = 0.0;
    for (NSInteger i = 0; i < values.count; i++) {
        if (midCounter > half) {
            midIndex = i;
            break;
        }
        midCounter += [values[i]floatValue];
        // Calculate sum of first half
        firstTotal += [values[i]floatValue];
    }
    // Split into halves based on middle sum index of original value array
    NSArray *firstHalf = [values subarrayWithRange:NSMakeRange(0, midIndex)];
    NSArray *secondHalf = [values subarrayWithRange:NSMakeRange(midIndex, values.count - midIndex)];
    // Get sum of second array
    CGFloat secondTotal = sum - firstTotal;
    // Get ratio of square based on sums of both arrays
    CGFloat squareRatio = 0.1;
    squareRatio = firstTotal / (firstTotal + secondTotal);
    // Calculate size of new frames based on square location
    CGRect firstRect, secondRect;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    if (height > width) { // Horizontal Square
        CGFloat heightRatio = height * squareRatio;
        firstRect = CGRectMake(rect.origin.x, rect.origin.y, width, heightRatio);
        secondRect = CGRectMake(rect.origin.x, rect.origin.y + heightRatio, width, height - heightRatio);
    }
    else { // Vertical Sqaure
        CGFloat widthRatio = width * squareRatio;
        firstRect = CGRectMake(rect.origin.x, rect.origin.y, widthRatio, height);
        secondRect = CGRectMake(rect.origin.x + widthRatio, rect.origin.y, width - widthRatio, height);
    }
    // Recursively call with new values and frames
    [self generateSquares:firstRect values:firstHalf];
    [self generateSquares:secondRect values:secondHalf];
}

/// Creates a random integer array from 1-50 based on input length
- (NSArray *)getRandomData:(NSInteger)length {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < length; i++) {
        NSInteger value = arc4random_uniform(1 + 50);
        [array addObject: @(value)];
    }
    return array;
}
/// Returns a random color
- (UIColor *)getRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}
/// Logs the value of square that's been tapped
- (void)squareTapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"%ld", (long)recognizer.view.tag);
}
@end
