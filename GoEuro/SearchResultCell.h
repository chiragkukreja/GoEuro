//
//  SearchResultCell.h
//  GoEuro
//
//  Created by Chirag Kukreja on 10/31/17.
//  Copyright © 2017 redBus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResponse;

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *stops;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

-(void)showData:(SearchResponse *)data;
@end
