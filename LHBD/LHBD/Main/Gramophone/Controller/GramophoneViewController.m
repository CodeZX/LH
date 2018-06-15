//
//  GramophoneViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GramophoneViewController.h"
#import "GramophoneTableViewCell.h"
#import "AudioModel.h"


static NSString *Identifier = @"GramophoneTableViewCell";
static NSString *audioPath = @"QLCP";

@interface GramophoneViewController ()<UITableViewDelegate,UITableViewDataSource>
// DZNEmptyDataSetSource
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIView *headerView;
@end

@implementation GramophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //设置导航栏透明
    //    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //    [self.tabBarController.tabBar setTranslucent:true];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    

}


//- (void)setupUI {
//
//    self.view.backgroundColor = WhiteColor;
//    self.navigationItem.title = @"留声机";
//
//    UITableView *tableView = [[UITableView alloc]init];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
//    tableView.emptyDataSetSource = self;
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.right.bottom.equalTo(self.view);
//    }];
//    [self.tableView registerNib:[UINib nibWithNibName:@"GramophoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Identifier];
//
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
//    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
//    [self.view addSubview:imageView];
//    self.headerView = imageView;
//    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [self.tableView.mj_header beginRefreshing];
//
//}

#pragma mark -------------------------- means ----------------------------------------
#pragma mark custom menas

- (NSArray *)getAllFileByName:(NSString *)path
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
    return array;
}

- (NSArray *)getAllfileByName:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * fileAndFloderArr = [self getAllFileByName:path];
    
    NSMutableArray *fileArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString * file in fileAndFloderArr){
        
        NSString *paths = [path stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:paths isDirectory:(&isDir)];
        if (!isDir) {
            [fileArray addObject:file];
        }
        isDir = NO;
    }
    return fileArray;
}

- (NSString *)fullPathAtDocument:(NSString *)fileName{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *directoryPath = [documentPath stringByAppendingPathComponent:@"QLCP"];
    if (![fm fileExistsAtPath:directoryPath]) {
        [fm createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [directoryPath stringByAppendingPathComponent:fileName];
}
- (NSString *)getAudiosPath {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *directoryPath = [documentPath stringByAppendingPathComponent:audioPath];
    if ([fm fileExistsAtPath:directoryPath]) {
        return directoryPath;
    }
    return nil;
}
#pragma mark respond  means
- (void)loadNewData {

//    self.dataSource = (NSMutableArray *) [self getAllFileByName:[self getAudiosPath]];
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView reloadData];
    
}
#pragma mark -------------------------- tableView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GramophoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSObject *Model = self.dataSource[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
////    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
////    return headerview;
//}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"还没有留言哦！"];
  
    return str;
    
}
#pragma mark -------------------------- lazy load ----------------------------------------

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
//        AvdioModel *avdio1 = [[AvdioModel alloc]init];
//        AvdioModel *avdio2 = [[AvdioModel alloc]init];
//        AvdioModel *avdio3 = [[AvdioModel alloc]init];
//        _dataSource = [NSMutableArray arrayWithArray: @[avdio1,avdio2,avdio3]];
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
