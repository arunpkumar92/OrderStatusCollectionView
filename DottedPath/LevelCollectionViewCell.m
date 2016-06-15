//
//  LevelCollectionViewCell.m
//  DottedPath
//
//  Created by Arun Kumar.P on 6/14/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

#import "LevelCollectionViewCell.h"

@interface LevelCollectionViewCell ()

@property (nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic) IBOutlet UILabel *dateLbl;
@property (nonatomic) IBOutlet UIImageView *imgView;


@end

@implementation LevelCollectionViewCell

- (void)setImgView:(UIImageView *)imgView{
    if (_imgView == imgView) {
        return;
    }
    _imgView = imgView;
    _imgView.layer.borderColor = [UIColor clearColor].CGColor;
    _imgView.layer.borderWidth = 0.0f;
    _imgView.layer.cornerRadius = _imgView.frame.size.width/2;
}

- (void)populateData:(int)index isActive:(BOOL)active{
    
    self.titleLbl.text = [NSString stringWithFormat:@"%d: Package arrived at a courier facility.",index];
    self.imgView.backgroundColor = active ? [UIColor colorWithRed:0.078 green:0.557 blue:0.067 alpha:1.00] : [UIColor colorWithRed:0.957 green:0.659 blue:0.024 alpha:1.00];

    int radius = (self.frame.size.height/4);
    
    CGFloat startAngle = M_PI;
    CGFloat endAngle = 3 * M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.frame.size.width/2), (self.frame.size.width/2)) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.strokeStart = 0.0;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.strokeColor = active ? [UIColor colorWithRed:0.078 green:0.557 blue:0.067 alpha:1.00].CGColor : [UIColor colorWithRed:0.957 green:0.659 blue:0.024 alpha:1.00].CGColor;
    shapelayer.lineWidth = 1.0f;
    shapelayer.cornerRadius = 0.5;
    //shapelayer.position = CGPointMake((self.frame.size.width/4),
//                               (self.frame.size.height/4));
    shapelayer.lineJoin = kCALineJoinRound;
    shapelayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:15],[NSNumber numberWithInt:10 ], nil];
    shapelayer.path = path.CGPath;
    
    [self.layer addSublayer:shapelayer];
    
}

@end
