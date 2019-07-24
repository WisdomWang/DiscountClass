//
//  findHotCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "findHotCell.h"

@interface findHotCell () <SDCycleScrollViewDelegate>

@end

@implementation findHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        _picImg = [[UIImageView alloc]init];
//        _picImg.image = [UIImage imageNamed:@"mainBanner"];
//        [self.contentView addSubview:_picImg];
//        [_picImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView.mas_top).offset(10);
//            make.left.equalTo(self.mas_left).offset(17);
//            make.right.equalTo(self.mas_right).offset(-17);
//            make.height.mas_equalTo(125);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        }];
//
//        _picImg.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoHotDetail)];
//        [_picImg addGestureRecognizer:tap];
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        _cycleScrollView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        _cycleScrollView.delegate = self;
        [self addSubview:_cycleScrollView];
        [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(17);
            make.right.equalTo(self.mas_right).offset(-17);
            make.height.mas_equalTo(125);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    self.gotoDetailBlock(index);
}

@end
