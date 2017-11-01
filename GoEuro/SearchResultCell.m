//
//  SearchResultCell.m
//  GoEuro
//
//  Created by Chirag Kukreja on 10/31/17.
//  Copyright © 2017 redBus. All rights reserved.
//

#import "SearchResultCell.h"
#import "GoEuro-Swift.h"
@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse {
    [super prepareForReuse];
    
}

-(void)showData:(SearchResponse *)data {
    
    self.time.text = [NSString stringWithFormat:@"%@ - %@", data.departureTime,data.arrivalTime];
    self.price.text = [NSString stringWithFormat:@"€ %.2f", data.price];
    if (data.stops > 0){
        self.stops.text = [NSString stringWithFormat:@"%ld change", (long)data.stops];
    }
    self.duration.text = [data duration];
   
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
         NSString * str = [data.logo stringByReplacingOccurrencesOfString:@"{size}" withString:@"63" options:NSCaseInsensitiveSearch range:NSMakeRange(0, data.logo.length)];
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            
            UIImage *image  = [UIImage imageWithData: data];
            
            self.logo.image = image;
            
            
        });
    });
}
@end
