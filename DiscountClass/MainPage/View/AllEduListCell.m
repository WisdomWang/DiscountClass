


//
//  AllLessonListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/14.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AllEduListCell.h"
#import "ThirdLibsHeader.h"

@implementation AllEduListCell

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
        
        _img = [[UIImageView alloc]initWithFrame:self.contentView.frame];
        _img.image = [UIImage imageNamed:@"testEduLogo"];
        _img.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(40);
        }];
       
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(17);
            make.left.equalTo(self.img.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.numberOfLines = 0;
        _addressLabel.preferredMaxLayoutWidth = xScreenWidth - 200;
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
        }];
        
        for (int i = 0; i<4; i++) {
            
            
           UILabel *kindLabel = [[UILabel alloc]init];
            kindLabel.textColor = [UIColor colorWithHexString:@"#f44640"];
            kindLabel.font = [UIFont systemFontOfSize:10];
            kindLabel.layer.borderWidth = 0.5;
            kindLabel.layer.borderColor = [[UIColor colorWithHexString:@"#f44640"] CGColor];
            kindLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:kindLabel];
            kindLabel.tag = i+300;
            kindLabel.hidden = YES;
            if (i == 0) {
                [kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.addressLabel.mas_bottom).offset(12);
                    make.left.equalTo(self.addressLabel.mas_left).offset(i*37);
                    make.width.mas_equalTo(30);
                    make.height.mas_equalTo(16);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
                }];
            } else {
                
                UILabel *lastLabel = [self.contentView viewWithTag:i+300-1];
                [kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.addressLabel.mas_bottom).offset(12);
                    make.left.equalTo(lastLabel.mas_right).offset(7);
                    make.width.mas_equalTo(30);
                    make.height.mas_equalTo(16);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
                }];
            }
        }
    }
    
    return self;
}

- (void)setModel:(EduArrModel *)model {
    
    _titleLabel.text = model.eduName;
    _addressLabel.text = model.address;
    [_img sd_setImageWithURL: [NSURL URLWithString:model.icon]];
    
    for (int i = 0; i<model.labelList.count; i++) {
        
        UILabel *label = [self.contentView viewWithTag:i+300];
        NSString *kindStr = model.labelList[i];
        label.text = model.labelList[i];
        label.hidden = NO;
        if (kindStr.length >=4) {
            [label mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_equalTo(50);
            }];
        }
        else {
            [label mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(30);
            }];
        }
    }
    for (int a = 0; a<4-model.labelList.count; a++) {
        
        UILabel *otherLabel = [self.contentView viewWithTag:303-a];
        otherLabel.hidden = YES;
    } 
}

@end
