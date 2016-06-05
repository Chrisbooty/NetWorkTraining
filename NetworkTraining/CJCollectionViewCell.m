//
//  CJCollectionViewCell.m
//  NetworkTraining
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CJCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backImgeView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;

@end

@implementation CJCollectionViewCell

-(void)awakeFromNib
{
    _userIconView.layer.cornerRadius = 21.0f;
    _userIconView.clipsToBounds = YES;
}


-(void)setModel:(CJModel *)model
{
    _model = model;
    [_backImgeView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"photo"]];
    _titleL.text = model.title;
    _priceL.text = [NSString stringWithFormat:@"¥ %@",model.discount_price];
    [_userIconView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"photo"]];
}

@end
