//
//  GramophoneViewControllerCellTwo.m
//  BasicFramework
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GramophoneViewControllerCellTwo.h"

@interface GramophoneViewControllerCellTwo  ()
@property (nonatomic,weak) UIView *leftView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UIImageView *trayImg;
@property (nonatomic,weak) UIImageView *styli;
@property (nonatomic,weak) UILabel *datalabel;
@property (nonatomic,weak) UIImageView *lockImageView;
@property (nonatomic,weak) UIImageView *cancelImageView;
@property (nonatomic,weak) UIButton *deleteBtn;



@end
@implementation GramophoneViewControllerCellTwo
{
    CGFloat angle;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        [self setupGesture];
//        [self startAnimation];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayer) name:@"sotpPlayer" object:nil];
    }
    return self;
}

- (void)stopPlayer {
    
    self.stop = YES;
    self.action = NO;
    
    
}


- (void)setupUI {

//    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.contentView.layer.cornerRadius = 5;

    UIImageView *trayImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_disc"]];
//    trayImg.backgroundColor = RandomColor;
    [self.contentView addSubview:trayImg];
    self.trayImg = trayImg;
    [self.trayImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];

    UIImageView *styli = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_styli"]];
    //    styli.backgroundColor = RandomColor;
    [self.contentView addSubview:styli];
    self.styli = styli;
    [self.styli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.size.equalTo(CGSizeMake(25, 61));
    }];

    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mask"]];
    [self.contentView addSubview:leftView];
    self.leftView = leftView;
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
//            make.bottom.equalTo(self.contentView).offset(-15);
        make.height.equalTo(25);
            make.width.equalTo(self.contentView).multipliedBy(.6);
    }];


    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.text  = @"未命名";
//    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.alpha = .6;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.leftView addSubview:titleLabel];
    self.titleLabel= titleLabel;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftView);
        make.bottom.equalTo(self.leftView).offset(-2);
        make.left.equalTo(self.leftView).offset(2);
        make.right.equalTo(self.leftView).offset(-2);
    }];


    UILabel *datalabel = [[UILabel alloc] init];
    datalabel.font = [UIFont systemFontOfSize:7];
    datalabel.text = @"某月某日";
//    datalabel.textColor = WhiteColor;
    datalabel.alpha = .6;
    datalabel.textAlignment = NSTextAlignmentCenter;
    datalabel.backgroundColor = [UIColor clearColor];
    [self.leftView addSubview:datalabel];
    self.datalabel = datalabel;
    [self.datalabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftView);
        make.top.equalTo(self.leftView).offset(2);
        make.left.equalTo(self.leftView).offset(2);
        make.right.equalTo(self.leftView).offset(-2);
    }];

    UIImageView *lockImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suo"]];
    //    styli.backgroundColor = RandomColor;
    [self.contentView addSubview:lockImageView];
    self.lockImageView = lockImageView;
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    lockImageView.hidden = YES;

//    UIImageView *cancelImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suo"]];
//    //    styli.backgroundColor = RandomColor;
//    [self.contentView addSubview:cancelImageView];
//    self.cancelImageView = cancelImageView;
//    [self.cancelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-5);
//        make.top.equalTo(self.contentView).offset(5);
//        make.size.equalTo(CGSizeMake(20, 20));
//    }];
//    cancelImageView.hidden = YES;


    UIButton *deleteBtn = [[UIButton alloc] init];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.contentView).offset(5);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    deleteBtn.hidden = YES;

}

- (void)deleteBtnClicked:(UIButton *)Btn {
    
    if ([self.delegate respondsToSelector:@selector(removeGramophoneViewControllerCellTwo:)]) {
        [self.delegate removeGramophoneViewControllerCellTwo:self];
    }
    
}

- (void)setupGesture {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.contentView addGestureRecognizer:longPress];
}


- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
    
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.deleteBtn.hidden = NO;
        self.deleteBtn.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd-HH-mm-ss+0800";
    NSDate *data = [df dateFromString:title];
    df.dateFormat = @"MM月dd";
    self.titleLabel.text = [df stringFromDate:data];
    
    
}


- (void)setAudioModel:(AudioModel *)audioModel {
    _audioModel = audioModel;
    self.deleteBtn.hidden = YES;
    self.lockImageView.hidden = YES;

    self.titleLabel.text = audioModel.title;
    NSDate *date = [NSDate jk_dateWithString:audioModel.date format:@"yyyy-MM-dd-HH-mm-ss+0800"];
    long int day = [date jk_day];
    long int month = [date jk_month];
    self.datalabel.text = [NSString stringWithFormat:@"%ld月%ld日",month,day];
    if (audioModel.password.length != 0) {
        self.lockImageView.hidden = NO;
    }
}

- (void)startAnimation {
    
    if (!self.action) {
        self.action = YES;
        [self action];
    }
    
}

- (void)action {
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.trayImg.transform = endAngle;
    } completion:^(BOOL finished) {
        if (!self.stop) {
            angle += 2; [self action];
        }
    }];
    
}



@end
