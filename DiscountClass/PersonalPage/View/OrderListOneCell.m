//
//  OrderListOneCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/22.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "OrderListOneCell.h"
#import "ThirdLibsHeader.h"

@implementation OrderListOneCell

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
        
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        [self.contentView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.width.equalTo(self.contentView.mas_width);
            make.height.mas_offset(16);
        }];
        
        _orderIdLabel = [[UILabel alloc]init];
        _orderIdLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _orderIdLabel.font = [UIFont systemFontOfSize:12];
        _orderIdLabel.text = @"订单编号：156135153153132135";
        [self.contentView addSubview:_orderIdLabel];
        [_orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.right.equalTo(self.contentView.mas_right).offset(100);
            make.height.mas_equalTo(40);
        }];
        
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delButton setImage:[UIImage imageNamed:@"deleteButton"] forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_delButton];
        [_delButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderIdLabel.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        
        UIView *oneLineView = [[UIView alloc]init];
        oneLineView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [self.contentView addSubview:oneLineView];
        [oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderIdLabel.mas_bottom);
            make.width.equalTo(self.contentView.mas_width);
            make.height.mas_offset(1);
        }];
        
        _eduLabel = [[UILabel alloc]init];
        _eduLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _eduLabel.font = [UIFont systemFontOfSize:12];
        _eduLabel.text = @"所属机构：新世界教育";
        _eduLabel.numberOfLines = 0;
        [self.contentView addSubview:_eduLabel];
        [_eduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneLineView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.height.mas_equalTo(40);
        }];
        
        UIView *twoLineView = [[UIView alloc]init];
        twoLineView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [self.contentView addSubview:twoLineView];
        [twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.eduLabel.mas_bottom);
            make.width.equalTo(self.contentView.mas_width);
            make.height.mas_offset(1);
        }];
        
        
        UIView *middleView = [[UIView alloc]init];
        middleView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        [self.contentView addSubview:middleView];
        [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoLineView.mas_bottom);
            make.width.equalTo(self.contentView.mas_width);
        }];
        
        _kindLabel = [[UILabel alloc]init];
        _kindLabel.textColor = [UIColor colorWithHexString:@"#f44640"];
        _kindLabel.font = [UIFont systemFontOfSize:10];
        _kindLabel.layer.borderWidth = 0.5;
        _kindLabel.layer.borderColor = [[UIColor colorWithHexString:@"#f44640"] CGColor];
        _kindLabel.text = @"学历";
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        [middleView addSubview:_kindLabel];
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView.mas_top).offset(16);
            make.left.equalTo(middleView.mas_left).offset(17);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(16);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.text = @"推荐推荐推荐推荐推荐推荐推荐推荐推荐推荐";
        _titleLabel.numberOfLines = 0;
        [middleView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView.mas_top).offset(16);
            make.left.equalTo(self.kindLabel.mas_right).offset(10);
            make.right.equalTo(middleView.mas_right).offset(-17);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.text = @"开课时间：请咨询机构";
        [middleView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(middleView.mas_left).offset(17);
            make.width.mas_equalTo(150);
        }];
        
        UILabel *placeLabel = [[UILabel alloc]init];
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:12];
        placeLabel.text = @"上课地点：";
        [middleView addSubview:placeLabel];
        [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(13);
            make.left.equalTo(middleView.mas_left).offset(17);
            make.width.mas_equalTo(62);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.numberOfLines = 0;
        _addressLabel.text = @"上课地点上课地点上课地点上课地点上课地点上课地点上课地点上课地点上课地点上课地点上课地点";
        [middleView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placeLabel.mas_top);
            make.left.equalTo(placeLabel.mas_right);
            make.right.equalTo(middleView.mas_right).offset(-17);
            make.bottom.equalTo(middleView.mas_bottom).offset(-24);
        }];
        
        _statusImg = [[UIImageView alloc]init];
        [middleView addSubview:_statusImg];
        [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(middleView.mas_centerY);
            make.right.equalTo(middleView.mas_right).offset(-17);
        }];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"共2件课程 实付款：￥21600";
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(40);
        }];
        
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即付款" forState:0];
        [_payButton setTitleColor:[UIColor colorWithHexString:@"#f44640"] forState:0];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _payButton.layer.cornerRadius = 12.5;
        _payButton.layer.borderWidth = 0.5;
        _payButton.layer.borderColor = [[UIColor colorWithHexString:@"#f44640"] CGColor];
        [_payButton addTarget:self action:@selector(gotoPayClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_payButton];
        [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.priceLabel.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(25);
        }];
   
    }
    return self;
}

- (void)setModel:(OrderListOneModel *)model {
    
    _orderIdLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.orderId];
    _priceLabel.text = [NSString stringWithFormat:@"共%@件课程，实付款：￥%@",model.courseNum,model.price];

    if (model.orderStatus == 0) {
        _statusImg.image = [UIImage imageNamed:@"orderStatusCancel"];
        _delButton.hidden = NO;
        _payButton.hidden = YES;
        
    }
    else if (model.orderStatus ==1) {
        _statusImg.image = [UIImage imageNamed:@"orderStatusWillPay"];
        _delButton.hidden = YES;
        _payButton.hidden = NO;
    }
    else if (model.orderStatus ==2) {
        _statusImg.image = [UIImage imageNamed:@"orderStatusWillDo"];
        _delButton.hidden = YES;
        _payButton.hidden = YES;
    }
    else if (model.orderStatus ==4) {
        _statusImg.image = [UIImage imageNamed:@"orderStatusFinal"];
        _delButton.hidden = NO;
        _payButton.hidden = YES;
    }
    
    OrderListTwoModel *twoModel = model.eduList[0];
    _eduLabel.text = [NSString stringWithFormat:@"所属机构：%@",twoModel.eduName];
    OrderListThreeModel *threeModel = twoModel.courseList[0];;
    _kindLabel.text = threeModel.courseType;
    _titleLabel.text = threeModel.courseName;
    _addressLabel.text = threeModel.address;
    
    if ([threeModel.courseType isEqualToString: @"职业技能"]) {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
        }];
    } else {
        [_kindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(30);
        }];
    }
    
}

- (void)deleteClick:(UIButton *)button {
    
    self.deleteOrderBlock();
}

- (void)gotoPayClick {
    
    self.payOrderBlock();
}

@end
