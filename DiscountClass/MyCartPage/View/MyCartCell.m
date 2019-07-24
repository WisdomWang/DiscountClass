//
//  MyCartCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/6.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MyCartCell.h"
#import "ThirdLibsHeader.h"

@implementation MyCartCell

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
        
        self.contentView.backgroundColor = [UIColor colorWithHexString: @"#f8f8f8"];
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.right.equalTo(self.contentView.mas_right).offset(-16);
            make.height.equalTo(self.contentView.mas_height);
        }];
        
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"unselectedButton"] forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_selectedButton];
        [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(25);
            make.left.equalTo(bgView.mas_left).offset(16);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
        }];
        
        _kindLabel = [[UILabel alloc]init];
        _kindLabel.textColor = [UIColor colorWithHexString:@"#f44640"];
        _kindLabel.font = [UIFont systemFontOfSize:10];
        _kindLabel.layer.borderWidth = 0.5;
        _kindLabel.layer.borderColor = [[UIColor colorWithHexString:@"#f44640"] CGColor];
        _kindLabel.text = @"学历";
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(25);
            make.left.equalTo(self.selectedButton.mas_right).offset(10);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(16);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = @"推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐";
        _titleLabel.numberOfLines = 0;
        [bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(25);
            make.left.equalTo(self.kindLabel.mas_right).offset(10);
            make.right.equalTo(bgView.mas_right).offset(-16);
        }];
        
        
        UILabel *placeLabel1 = [[UILabel alloc]init];
        placeLabel1.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel1.font = [UIFont systemFontOfSize:11];
        placeLabel1.text = @"开课时间：";
        [bgView addSubview:placeLabel1];
        [placeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(bgView.mas_left).offset(17);
            make.width.mas_equalTo(60);
        }];
        
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.text = @"请咨询机构";
        [bgView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(placeLabel1.mas_right);
            make.right.equalTo(bgView.mas_right).offset(-17);
        }];
        
        UILabel *placeLabel = [[UILabel alloc]init];
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:11];
        placeLabel.text = @"上课地点：";
        [bgView addSubview:placeLabel];
        [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(13);
            make.left.equalTo(bgView.mas_left).offset(17);
            make.width.mas_equalTo(60);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _addressLabel.font = [UIFont systemFontOfSize:11];
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placeLabel.mas_top);
            make.left.equalTo(placeLabel.mas_right);
            make.right.equalTo(bgView.mas_right).offset(-17);
        }];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#ffle00"];
        _priceLabel.font = [UIFont systemFontOfSize:17];
        _priceLabel.numberOfLines = 0;
        _priceLabel.text = @"￥12800";
        [bgView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom).offset(12);
            make.left.equalTo(bgView.mas_left).offset(17);
            make.bottom.equalTo(bgView.mas_bottom).offset(-24);
        }];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"addButton"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.priceLabel.mas_centerY);
            make.right.equalTo(bgView.mas_right).offset(-15);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
        }];
        
        _numLabel = [[UILabel alloc]init];
        _numLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _numLabel.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        _numLabel.font = [UIFont systemFontOfSize:17];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = @"1";
        [bgView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.priceLabel.mas_centerY);
            make.right.equalTo(self.addButton.mas_left).offset(-8);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(22);

        }];
        
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setImage:[UIImage imageNamed:@"reduceButton"] forState:UIControlStateNormal];
        [_reduceButton addTarget:self action:@selector(cutClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_reduceButton];
        [_reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.priceLabel.mas_centerY);
            make.right.equalTo(self.numLabel.mas_left).offset(-8);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
        }];
        
    }
    return self;
}

- (void)setLessonModel:(CartLessonModel *)lessonModel {
    
    _lessonModel = lessonModel;
    _kindLabel.text = lessonModel.courseType;
    _titleLabel.text = lessonModel.courseName;
    _addressLabel.text = lessonModel.address;
    _priceLabel.text = lessonModel.price;
    
    if ([lessonModel.courseType isEqualToString: @"职业技能"]) {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
        }];
    } else {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(30);
        }];
    }
    
    self.selectedButton.selected = lessonModel.isSelect;
    if (lessonModel.isSelect) {
        [self.selectedButton setImage:[UIImage imageNamed:@"selectedButton"] forState:(UIControlStateNormal)];
    } else {
        [self.selectedButton setImage:[UIImage imageNamed:@"unselectedButton"] forState:(UIControlStateNormal)];
    }
}

- (void)selectedClick:(UIButton *)button {

    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"selectedButton"] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageNamed:@"unselectedButton"] forState:UIControlStateNormal];
    }
    if (self.ClickRowBlock) {
        self.ClickRowBlock(button.selected);
    }
    
}

- (void)addClick:(UIButton *)button {
    
//    NSInteger count = [self.numLabel.text integerValue];
//    count ++;
//    self.numLabel.text = [NSString stringWithFormat:@"%ld",count];
//    if (self.AddBlock) {
//        self.AddBlock(self.numLabel);
//    }
}

- (void)cutClick:(UIButton *)button {
    
//    NSInteger count = [self.numLabel.text integerValue];
//    count --;
//    if (count <=0) {
//        return;
//    }
//    self.numLabel.text = [NSString stringWithFormat:@"%ld",count];
//    if (self.CutBlock) {
//        self.CutBlock(self.numLabel);
//    }
}

@end
