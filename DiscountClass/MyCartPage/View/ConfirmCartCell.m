//
//  ConfirmCartCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "ConfirmCartCell.h"
#import "ThirdLibsHeader.h"

@implementation ConfirmCartCell

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
        
        _kindLabel = [[UILabel alloc]init];
        _kindLabel.textColor = [UIColor colorWithHexString:@"#f44640"];
        _kindLabel.font = [UIFont systemFontOfSize:10];
        _kindLabel.layer.borderWidth = 0.5;
        _kindLabel.layer.borderColor = [[UIColor colorWithHexString:@"#f44640"] CGColor];
        _kindLabel.text = @"学历";
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(16);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = @"推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐";
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.left.equalTo(self.kindLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-16);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.text = @"开课时间：请咨询机构";
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(150);
        }];
        
        UILabel *placeLabel = [[UILabel alloc]init];
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:11];
        placeLabel.text = @"上课地点：";
        [self.contentView addSubview:placeLabel];
        [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(13);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _addressLabel.font = [UIFont systemFontOfSize:11];
        _addressLabel.numberOfLines = 0;
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placeLabel.mas_top);
            make.left.equalTo(placeLabel.mas_right);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
        
        
    }
    return self;
}

- (void)setModel:(CartLessonModel *)model {
    
    _kindLabel.text = model.courseType;
    _titleLabel.text = model.courseName;
    _addressLabel.text = model.address;
    if ([model.courseType isEqualToString: @"职业技能"]) {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
        }];
    } else {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(30);
        }];
    }
}

@end
