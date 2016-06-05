//
//  CJFirstTableViewCell.m
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJFirstTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CJFirstTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation CJFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code

}


-(void)setModel:(CJFirstCellGroupModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"photo"]];
    _nameL.text = model.name;
    _title.text = [NSString stringWithFormat:@"%@个达人·%@条路线",model.guide,model.route];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
