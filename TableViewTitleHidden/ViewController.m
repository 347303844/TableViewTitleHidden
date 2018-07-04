//
//  ViewController.m
//  TableViewTitleHidden
//
//  Created by 吕召 on 2018/7/4.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "BillTitleView.h"
#import "BillHeaderView.h"
#import "UIDevice+iPhoneX.h"
#import "UIColor+HexColor.h"
#import "UIView+LZSize.h"



///屏幕的宽
#define K_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
///屏幕的高
#define K_SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
///导航栏的高度
#define K_NAVHEIGHT  ((K_SCREENHEIGHT == 812)? 88 : 64)
///tabbar的高度
#define K_BARHEIGHT  ((K_SCREENHEIGHT == 812) ? 83 : 49)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

//导航栏View
@property (nonatomic,strong) BillTitleView * titleView;

//headView
@property (nonatomic,strong) BillHeaderView * headerView;

//偏移量
@property (nonatomic,assign) CGFloat tableViewTopOffset;

//导航栏View
@property (nonatomic,strong) UIImageView * navigationBarBackgroundView;

//shadowImage
@property (nonatomic,strong) UIImage * shadowImage;

//初始化值一次
@property (nonatomic,assign) BOOL bInitRange;

// y轴方向需要移动的距离
@property (nonatomic,assign) CGFloat yRange;

// x轴方向需要移动的距离
@property (nonatomic,assign) CGFloat xRange;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.tableView.backgroundColor =  [UIColor colorWithHexString:@"0x1E90FF"];

    CGFloat statusHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    self.tableViewTopOffset = 0 - statusHeight + 44;
    self.tableView.contentInset = UIEdgeInsetsMake(0 - (statusHeight+ 44), 0, -44, 0);

    self.navigationItem.titleView = self.titleView;
    UIImage * navigationBarBackgroundImage = [UIColor switchToImageWithColor:[UIColor colorWithHexString:@"0x1E90FF"] size:CGSizeMake(10, 10)];
    self.navigationBarBackgroundView = [[UIImageView alloc]initWithImage:navigationBarBackgroundImage];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar insertSubview:self.navigationBarBackgroundView atIndex:0];
    CGFloat statusHeight = UIApplication.sharedApplication.statusBarFrame.size.height;

    self.navigationBarBackgroundView.frame = CGRectMake(0, 0 - statusHeight, K_SCREENWIDTH,self.navigationController.navigationBar.frame.size.height + statusHeight);
    self.navigationBarBackgroundView.alpha = 0;
    self.shadowImage = self.navigationController.navigationBar.shadowImage;

    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.bInitRange){
        self.bInitRange = YES;

        CGRect smallIconRect = [self.titleView convertRect:self.titleView.imageView.frame toView:self.view];

        CGRect bigIconRect = [self.headerView convertRect:self.headerView.imageView.frame toView:self.view];

        //底线的距离
        self.xRange = fabs(smallIconRect.origin.x - bigIconRect.origin.x);
        self.yRange = fabs((smallIconRect.origin.y + smallIconRect.size.height) - (bigIconRect.origin.y + bigIconRect.size.height)) ;



    }
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.shadowImage = self.shadowImage;
//    [self.navigationController.navigationBar setBackgroundImage:[UIColor switchToImageWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = NO;
    
}

#pragma mark - setupUI
- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo (self.view.safeAreaInsets);
        } else {
            make.edges.mas_equalTo(self.view);
        }
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UIDevice.isIphoneX ? 180 + 24: 180;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.yRange <= 0)return;
    
    NSLog(@"scrollView.contentOffset.y === %f",scrollView.contentOffset.y);

    if(scrollView.contentOffset.y <= 0) {
        if(self.headerView.imageView.frame.size.width == 60){
            return;
        } else
        {
            [self.headerView.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.width.height.mas_equalTo(60);
            }];
            return;
        }
    }
    

    //移动的百分比
    CGFloat ratioY = scrollView.contentOffset.y / self.yRange; // y轴上移动的百分比
    NSLog(@"ratioY === %f",ratioY);

    if(ratioY > 1) {
        self.headerView.nameLabel.alpha = 0;
        self.headerView.imageView.alpha = 0;
        self.titleView.imageView.hidden = NO;
        self.navigationBarBackgroundView.alpha = 1.0;
        return;
    }

    self.navigationBarBackgroundView.alpha = 0.0;
    self.headerView.nameLabel.alpha = 1 - ratioY;
    self.headerView.imageView.alpha = 1.0;
    self.titleView.imageView.hidden = YES;
    
    [self.headerView.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 + self.xRange * ratioY);
        make.width.height.mas_equalTo(60 - 30 * ratioY);

    }];
    self.headerView.imageView.layer.cornerRadius = (60 - 30 * ratioY) /2.0;

}

#pragma mark - get and set
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
    
}


//headView
- (BillHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[BillHeaderView alloc]init];
        _headerView.frame = CGRectMake(0, 0, K_SCREENWIDTH, UIDevice.isIphoneX ? 180 + 24: 180);
    }
    return _headerView;
    
}

//titleView
- (BillTitleView *)titleView{
    
    if(!_titleView){
        _titleView = [[BillTitleView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    }
    return _titleView;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

