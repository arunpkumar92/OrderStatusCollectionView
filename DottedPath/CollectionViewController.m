//
//  CollectionViewController.m
//  DottedPath
//
//  Created by Arun Kumar.P on 6/13/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

#import "CollectionViewController.h"
#import "LevelCollectionViewCell.h"

@interface CollectionViewController ()

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) int noOfItems;
@property (nonatomic) int total;
@property (nonatomic) int currentLevel;
@property (nonatomic) NSMutableArray *connectionLines;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"ReuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.borderWidth = 1.0f;
    self.noOfItems = 3;
    self.total = 8;
    self.currentLevel = 3;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self reloadConnections];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadConnections{
    
    for (CAShapeLayer *shapelayer in self.connectionLines) {
        [shapelayer removeFromSuperlayer];
    }
    
    self.connectionLines = [NSMutableArray array];
    
    for (int i = 0; i <= (self.total-2); i++){
        NSArray *paths = [self pathForconnectionLineForIndexPath:i];
        for (UIBezierPath *path in paths) {
            UIColor *color = (self.currentLevel > i) ? [UIColor colorWithRed:0.078 green:0.557 blue:0.067 alpha:1.00] : [UIColor colorWithRed:0.957 green:0.659 blue:0.024 alpha:1.00];
            CAShapeLayer *shapelayer = [self drawdottedLineWithPath:path withborderWidth:1.0f withColor:color];
            [self.collectionView.layer addSublayer:shapelayer];
            [self.connectionLines addObject:shapelayer];
        }
    }
    
}

- (NSArray *)pathForconnectionLineForIndexPath:(int)index{
    NSMutableArray *paths = [NSMutableArray array];
    
    int row = index%self.noOfItems;
    int column = index/self.noOfItems;
    CGFloat cellWidth = self.view.frame.size.width/self.noOfItems;
    CGFloat cellHeight = self.view.frame.size.width/self.noOfItems;
    CGFloat connectionLength = cellHeight/2;

    CGFloat leftPadding;
    CGFloat topPadding;

    if (row != (self.noOfItems-1)) {
        leftPadding = cellWidth/4;
        topPadding = cellHeight/2;
        
        UIBezierPath *borderPath = [UIBezierPath bezierPath];
        CGFloat startX = (3*leftPadding)+(row*cellWidth);
        CGFloat startY = topPadding+(column*cellHeight);
        CGFloat endX = startX + connectionLength;
        CGFloat endY = startY;
        [borderPath moveToPoint:CGPointMake(startX , startY)];
        [borderPath addLineToPoint:CGPointMake(endX,  endY)];
        [self drawDirectionAt:CGPointMake((startX+(connectionLength/2)) , startY) isEnabled:(self.currentLevel > index) isRight:YES];
        [paths addObject:borderPath];

    }
    
    if ( (row == (self.noOfItems-1)) && (column%2 == 0) ) {
        leftPadding = cellWidth/2;
        topPadding = cellHeight/8;
        
        UIBezierPath *borderPath = [UIBezierPath bezierPath];
        CGFloat startX = leftPadding+(row*cellWidth);
        CGFloat startY = (7*topPadding)+(column*cellHeight);
        CGFloat endX = startX;
        CGFloat endY = startY + (2*topPadding);
        [borderPath moveToPoint:CGPointMake(startX , startY)];
        [borderPath addLineToPoint:CGPointMake(endX,  endY)];
        [self drawDirectionAt:CGPointMake(startX , (startY+topPadding)) isEnabled:(self.currentLevel > index) isRight:NO];
        [paths addObject:borderPath];
        
    }
    
    if ( (row == 0) && (column%2 != 0) ) {
        leftPadding = cellWidth/2;
        topPadding = cellHeight/8;
        
        UIBezierPath *borderPath = [UIBezierPath bezierPath];
        CGFloat startX = leftPadding+(row*cellWidth);
        CGFloat startY = (7*topPadding)+(column*cellHeight);
        CGFloat endX = startX;
        CGFloat endY = startY + (2*topPadding);
        [borderPath moveToPoint:CGPointMake(startX , startY)];
        [borderPath addLineToPoint:CGPointMake(endX,  endY)];
        [self drawDirectionAt:CGPointMake(startX , (startY+topPadding)) isEnabled:(self.currentLevel > index) isRight:NO];
        [paths addObject:borderPath];
        
    }
    
    return paths;
}

- (CAShapeLayer *)drawdottedLineWithPath:(UIBezierPath *)path withborderWidth:(CGFloat)lineWidth withColor: (UIColor *)color
{
   
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.strokeStart = 0.0;
    shapelayer.strokeColor = color.CGColor;
    shapelayer.lineWidth = lineWidth;
    shapelayer.lineJoin = kCALineJoinRound;
    shapelayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:15],[NSNumber numberWithInt:10 ], nil];
    shapelayer.path = path.CGPath;
    
    return shapelayer;
    
}

- (void)drawDirectionAt:(CGPoint)point isEnabled:(BOOL)enabled isRight:(BOOL)isRight{
    NSString *imageName;
    imageName = isRight ? @"right-arrow" : @"down-arrow";
    imageName = [NSString stringWithFormat:@"%@-%@",imageName,(enabled ? @"enabled" : @"disabled")];
    
    CAShapeLayer* direction = [CAShapeLayer layer];
    direction.opacity = 1.0;
    direction.frame = CGRectMake(0, 0, 16, 16);
    direction.position = point;
    [direction setContents:(id)[[UIImage imageNamed: imageName] CGImage]];
    [self.connectionLines addObject:direction];
    [self.collectionView.layer addSublayer: direction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.total;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LevelCollectionViewCell *cell = (LevelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell populateData:indexPath.row isActive:(self.currentLevel > indexPath.row)];
//    cell.layer.borderWidth = 1.0f;
//    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 0.0f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.view.frame.size.width/self.noOfItems, self.view.frame.size.width/self.noOfItems);
    
}


/** creating dotted line **/



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
