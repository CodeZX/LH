//
//  GramophoneViewControllerTwo.m
//  BasicFramework
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GramophoneViewControllerTwo.h"
#import "GramophoneViewControllerCellTwo.h"
#import <AVFoundation/AVFoundation.h>
#import "collectionHeaderView.h"
#import "AudioModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "XTJWebNavigationViewController.h"

#import "AudioManager.h"
#import "AppDelegate.h"
#import "Audio+CoreDataClass.h"
//#import "XTJWebNavigationViewController.h"


static NSString *const collectionViewCellIdentifier =  @"collectionViewCellIdentifier";
static NSString* const collectionViewHeaderIdentifier = @"header";
static NSString *audioPath = @"QLCP";


@interface GramophoneViewControllerTwo ()<UICollectionViewDelegate,UICollectionViewDataSource,AVAudioPlayerDelegate,GramophoneViewControllerCellTwoDelegate,DZNEmptyDataSetSource>
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) UIImageView *headImageView; ;
@property(nonatomic, strong) AVAudioPlayer *player;


@property (nonatomic,strong) NSMutableArray *todayDataSource;
@property (nonatomic,strong) NSMutableArray *otheDataSource;
@end

@implementation GramophoneViewControllerTwo
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSAttributedString *stirng = [[NSAttributedString alloc]initWithString:@"没有留言！"];
    return stirng;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    self.navigationItem.title = @"留声机";
    [self setupUI];
    [self netWork];
}
- (void)netWork {
    
    NSDictionary *dic = @{@"appId":@"tj2_20180611008"};
    [NetWorkManager requestDataForPOSTWithURL:@"http://119.148.162.231:8080/app/get_version" parameters:dic Controller:nil UploadProgress:^(float progress) {

    } success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"0"]) {
            NSDictionary *retDataDic = dic[@"retData"];
            if ([retDataDic[@"version"] isEqualToString:@"2.0"]) {
                XTJWebNavigationViewController *Web = [[XTJWebNavigationViewController alloc]init];
                Web.url = retDataDic[@"updata_url"];
                [self presentViewController:Web animated:NO completion:nil];
            }

        }
    } failure:^(NSError *error) {

    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    //设置导航栏透明
    //    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:WhiteColor];
    //    [self.tabBarController.tabBar setTranslucent:true];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];//---便捷颜色---color for test---用来 Debug 的颜色

    [self.collectionView.mj_header beginRefreshing];
    
}


- (void)setupUI  {

    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"留声机";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self  action:@selector(rightSearch:)];


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset  = UIEdgeInsetsMake(0, 20, 0, 20);

    UICollectionView *collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(20, 0,60, 0);
    collectionView.backgroundColor = WhiteColor;
    collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back ground"]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.emptyDataSetSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [self.collectionView registerClass:[GramophoneViewControllerCellTwo class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    [self.collectionView registerClass:[collectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderIdentifier];

    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
//    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark -------------------------- means ----------------------------------------

#pragma mark custom menas

//- (NSArray *)getAllFileByName:(NSString *)path
//{
//    NSFileManager *defaultManager = [NSFileManager defaultManager];
//    NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
//    return array;
//}

- (NSArray *)getAllfileByName:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * fileAndFloderArr = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
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
    
//    [self.todayDataSource removeAllObjects];
//    [self.otheDataSource removeAllObjects];
//    AudioManager *audioManager = [AudioManager sharedAudioManager];
//    YYCache *audioCache = audioManager.audioCache;
//    self.dataSource = [audioCache objectForKey:KeyAudioAry];
//    self.dataSource = (NSMutableArray *) [self getAllfileByName:[self getAudiosPath]];
//    for (AudioModel *model in self.dataSource) {
//
//        NSDate *date = [NSDate dateWithString:model.date format:@"yyyy-MM-dd-HH-mm-ss+0800"];
//        if (!(model.password.length > 0)) {
//            if ([date jk_isToday] ) {
//                [self.todayDataSource addObject:model];
//            }else {
//                [self.otheDataSource addObject:model];
//            }
//        }
//
//
//    }
    
    [self.dataSource removeAllObjects];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    // 建立获取数据的请求对象，指明操作的实体为Employee
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Audio"];
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"password = %@", NULL];
    request.predicate = predicate;
    // 执行获取操作，获取所有Employee托管对象
    NSError *error = nil;
    NSArray *employees = [context executeFetchRequest:request error:&error];

    [employees enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Audio *audio = obj;
        NSLog(@"Employee Name : %@, Height : %@, Brithday : %@  path:%@", audio.name, audio.date, audio.password,audio.path);
        AudioModel *model = [[AudioModel alloc]initWithTitle:audio.name Path:audio.path Date:audio.date Password:audio.password];
        [self.dataSource addObject:model];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    }];
    // 错误处理
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
    
    [self.collectionView.mj_header endRefreshing];
    
}

- (void)rightSearch:(UIButton *)btn {
    
    
}

#pragma mark -------------------------- collectionView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.dataSource.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GramophoneViewControllerCellTwo *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    //    cell.contentView.backgroundColor = RandomColor;
//    <#class#> *model =  self.searchDataSource ? self.searchDataSource[indexPath.row]:self.dataSource[indexPath.row];
//    cell.specialistModel = model;\
     cell.backgroundColor = ClearColor;
//    if (indexPath.section == 0) {
////         cell.title = self.todayDataSource[indexPath.row];
//        cell.audioModel = self.todayDataSource[indexPath.row];
//    }else {
////        cell.title = self.otheDataSource[indexPath.row];
//        cell.audioModel = self.otheDataSource[indexPath.row];
//    }
    cell.audioModel = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GramophoneViewControllerCellTwo *cell = (GramophoneViewControllerCellTwo *) [collectionView cellForItemAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sotpPlayer" object:nil userInfo:nil];
    cell.stop = NO;

    AudioModel *model = self.dataSource[indexPath.row];
//    if (indexPath.section == 0) {
//        model = self.todayDataSource[indexPath.row];
//    }else {
//       model = self.otheDataSource[indexPath.row];
//    }
    NSString *audioPath = [self fullPathAtDocument:model.date];
    if ([[NSFileManager defaultManager] fileExistsAtPath:audioPath]) {
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:audioPath] error:nil];
        self.player.delegate = self;
        [self.player play];
        [cell startAnimation];
    }else {
        [self showToast:@"文件获取失败！"];
    }
    
//    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:audioPath] error:nil];
//    self.player.delegate = self;
//    [self.player play];
//    [cell startAnimation];

    
    
}

//设置sectionHeader | sectionFoot
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        collectionHeaderView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            view.label.text = @"今天";
        } else {
            
            view.label.text = @"其他";
        }
        return view;
    }else{
        return nil;
    }
}

//执行的 headerView 代理  返回 headerView 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   
    return CGSizeMake(320, 40);
}



#pragma mark -------------------------- audioPlayer delegate ----------------------------------------

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sotpPlayer" object:nil userInfo:nil];
}


#pragma mark -------------------------- gramophonViewControllerTwo delegate ----------------------------------------

- (void)removeGramophoneViewControllerCellTwo:(GramophoneViewControllerCellTwo *)gramophoneViewControllerCellTwo {
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"报告！" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
    
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSIndexPath  *indexPath = [self.collectionView indexPathForCell:gramophoneViewControllerCellTwo];
            [self removeCellAtidexPath:indexPath];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

            
        }];
        [alert addAction:action];
        [alert addAction:actionCancel];
        [self presentViewController:alert animated:YES completion:nil];
}

- (void)removeCellAtidexPath:(NSIndexPath *)indexPath {
    
    AudioModel *audioModel = self.dataSource[indexPath.row];
    NSString *path = [self fullPathAtDocument:audioModel.date];
    [self deleteFileAtPath:path];
    [self.dataSource removeObjectAtIndex:indexPath.row];
//    [self synchronizeCache];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    // 建立获取数据的请求对象，指明对Employee实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Audio"];
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", audioModel.date];
    request.predicate = predicate;
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray *employees = [context executeFetchRequest:request error:&error];
    // 遍历符合删除要求的对象数组，执行删除操作
    [employees enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [context deleteObject:obj];
    }];
    [appDelegate saveContext];
   
    
}

/**
 同步到缓存
 */
//- (void)synchronizeCache {
//    
//    AudioManager *audioManager = [AudioManager sharedAudioManager];
//    YYCache *audioCache = audioManager.audioCache;
//    [audioCache removeObjectForKey:KeyAudioAry];
//    [audioCache setObject:self.dataSource forKey:KeyAudioAry];
//}

-(BOOL)deleteFileAtPath:(NSString *)path{
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager removeItemAtPath:path error:nil];
    return res;
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
}

- (BOOL)deleteFileByName:(NSString *)name{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [fileManager removeItemAtPath:[self getLocalFilePath:fileName] error:nil];//getLocalFilePath方法在下面
    NSString *path = @"";
    return [self deleteFileAtPath:path];
}
#pragma mark -------------------------- Lazy load ----------------------------------------

- (AVAudioPlayer *)player {
    
    if (!_player) {
        _player = [[AVAudioPlayer alloc]init];
    }
    return _player;
}

- (NSMutableArray *)todayDataSource {
    
    if (!_todayDataSource) {
        _todayDataSource = [[NSMutableArray alloc]init];
    }
    return _todayDataSource;
}

- (NSMutableArray *)otheDataSource {
    
    if (!_otheDataSource) {
        _otheDataSource = [[NSMutableArray alloc]init];
    }
    return _otheDataSource;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
@end
