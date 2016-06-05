//
//  CJSecondTableViewCell.m
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJSecondTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CJSecondTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;

@end

@implementation CJSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _userIconView.layer.cornerRadius = 25;
    _userIconView.clipsToBounds = YES;
//    _titleL.textColor = [UIColor blackColor];
//    _priceL.textColor = [UIColor redColor];
}


-(void)setModel:(CJModel *)model
{
    _model = model;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"photo"]];
    _titleL.text = model.title;
    _priceL.text = [NSString stringWithFormat:@"¥ %@",model.discount_price];
    [_userIconView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"photo"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
