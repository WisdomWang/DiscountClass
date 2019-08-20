//
//  MainListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/5.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MainListCell.h"
#import "ThirdLibsHeader.h"

@implementation MainListCell

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
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(21);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(16);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(21);
            make.left.equalTo(self.kindLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
        }];
        
        UILabel *feelLabel = [[UILabel alloc]init];
        feelLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        feelLabel.font = [UIFont systemFontOfSize:11];
        feelLabel.text = @"人气指数：";
        [self.contentView addSubview:feelLabel];
        [feelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(60);
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
            
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-21);
            
        }];
        
        UILabel *placeLabel = [[UILabel alloc]init];
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:11];
        placeLabel.numberOfLines = 0;
        placeLabel.text = @"上课地点：";
        [self.contentView addSubview:placeLabel];
        [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(feelLabel.mas_bottom).offset(13);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(60);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _addressLabel.font = [UIFont systemFontOfSize:11];
        _addressLabel.numberOfLines = 0;
      //  _addressLabel.preferredMaxLayoutWidth = xScreenWidth - 200;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placeLabel.mas_top);
            make.left.equalTo(placeLabel.mas_right);
            make.right.equalTo(self.contentView.mas_right).offset(-120);
            make.bottom.equalTo(self.priceLabel.mas_bottom);
        }];
        
    }
        return self;
    }

- (void)setModel:(LessonArrModel *)model {

    _kindLabel.text = model.courseType;
    if ([model.courseType isEqualToString: @"职业技能"]) {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(50);
        }];
    } else {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(30);
        }];
    }
    
    _titleLabel.text = model.courseName;
    _addressLabel.text = model.address;
    NSInteger price = [model.price integerValue];
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)price];
    for (int i = 0; i<[model.popularityNum integerValue]; i++) {
        
        UIImageView *img = [self.contentView viewWithTag:i+200];
        img.image = [UIImage imageNamed:@"popularityStart_light"];
    }
    
    for (int i = [model.popularityNum intValue]; i<5; i++) {
        
        UIImageView *img = [self.contentView viewWithTag:i+200];
        img.image = [UIImage imageNamed:@"popularityStart_dark"];
    }
}

@end
