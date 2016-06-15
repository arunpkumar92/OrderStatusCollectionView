//
//  LevelCollectionViewCell.h
//  DottedPath
//
//  Created by Arun Kumar.P on 6/14/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelCollectionViewCell : UICollectionViewCell

- (void)populateData:(int)index isActive:(BOOL)active;

@end
