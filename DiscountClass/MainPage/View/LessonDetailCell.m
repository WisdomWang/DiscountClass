//
//  LessonDetailCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LessonDetailCell.h"
#import "ThirdLibsHeader.h"

@implementation LessonDetailCell

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
        
        UIImageView *kindImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"labelImg"]];
        [self.contentView addSubview:kindImg];
        [kindImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
        
        _kindLabel = [[UILabel alloc]init];
        _kindLabel.textColor = [UIColor whiteColor];
        _kindLabel.font = [UIFont boldSystemFontOfSize:13];
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.centerY.equalTo(kindImg.mas_centerY).offset(0);
            make.width.equalTo(kindImg.mas_width);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kindLabel.mas_bottom).offset(5);
            make.left.equalTo(self.kindLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
        }];
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.text = @"开课时间：请咨询机构";
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.kindLabel.mas_left);
        }];
        
        UILabel *feelLabel = [[UILabel alloc]init];
        feelLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        feelLabel.font = [UIFont systemFontOfSize:12];
        feelLabel.text = @"人气指数：";
        [self.contentView addSubview:feelLabel];
        [feelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeLabel.mas_bottom).offset(10);
            make.left.equalTo(self.kindLabel.mas_left);
        }];
        
        for (int i = 0; i<5; i++) {
            UIImageView *img = [[UIImageView alloc]init];
            img.image = [UIImage imageNamed:@"popularityStart_dark"];
            [self.contentView addSubview:img];
            img.tag = i+200;
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(feelLabel.mas_centerY);
                make.left.equalTo(feelLabel.mas_right).offset(i*15);
            }];
        }
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#ffle00"];
        _priceLabel.font = [UIFont systemFontOfSize:24];
        _priceLabel.numberOfLines = 0;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(feelLabel.mas_bottom).offset(16);
            make.left.equalTo(self.kindLabel.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        }];
    }
    return self;
}

- (void)setModel:(LessonArrModel *)model {
    
    _kindLabel.text = model.courseType;
    _titleLabel.text = model.courseName;
    NSInteger price = [model.price integerValue];
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)price];
    for (int i = 0; i<[model.popularityNum integerValue]; i++) {
        
        UIImageView *img = [self.contentView viewWithTag:i+200];
        img.image = [UIImage imageNamed:@"popularityStart_light"];
    }
}


@end
