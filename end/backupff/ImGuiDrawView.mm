#import "NakanoIchika.h"
#import "NakanoNino.h"
#import "NakanoMiku.h"
#import "NakanoYotsuba.h"
#import "NakanoItsuki.h"
#import "Macros.h"
#import "Esp/ImGuiDrawView.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#include "KittyMemory/imgui.h"
#include "KittyMemory/imgui_impl_metal.h"
#import <Foundation/Foundation.h>
#import "Esp/CaptainHook.h"
#include <UIKit/UIKit.h>
#import "JRMemory.framework/Headers/MemScan.h"
#import "Esp/API/APIKey.h"


#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0 
#define g 0.86602540378444 

@interface ImGuiDrawView () <MTKViewDelegate>
//@property (nonatomic, strong) IBOutlet MTKView *mtkView;
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;










@end


float headx;
float heady;
#define Red 0x990000ff
#define Green 0x9900FF00
#define Yellow 0x9900ffff
#define Blue 0x99ff0000
#define Pink 0x99eb8cfe
#define White 0xffffffff

@implementation ImGuiDrawView

//yowx

static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

   ImGui::StyleColorsDarkMode();
    
NSString *FontPath = @"/System/Library/Fonts/AppFonts/Charter.ttc";
    io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 40.f,NULL,io.Fonts->GetGlyphRangesVietnamese());



    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}









#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate





- (void)drawInMTKView:(MTKView*)view
{

    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    
    static bool a1 = false;
    static bool a2 = false;
    static bool norecoil= false;
    static bool cu = false;
    static bool antena = false;
    static bool ak = false;
    static bool scar = false;
    static bool mp = false;
    static bool m1014 = false;
    static bool m1887 = false;
    static bool ump = false;
    static bool fake = false;
   static APIClient *apiClient;


       
        //
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 16.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 380) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 210) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(430, 260), ImGuiCond_FirstUseEver);
            
            if (MenDeal == true)
            {



			ImGui::Begin("YAPE-GAAA: 1.100.1 | Copyright: @yowxios", &MenDeal);
		{

		 


                    
		

                    ImGui::Checkbox("Aimbot", &a1);ImGui::SameLine();
                    ImGui::Checkbox("Fake Damage", &fake);

		    ImGui::Checkbox("Aim Scope", &a2);
		    ImGui::SameLine();
		    ImGui::Checkbox("Antena Hand", &antena);

		    ImGui::Checkbox("NoRecoil", &norecoil);
		    ImGui::SameLine();
		    ImGui::Checkbox("HS Cu", &cu);
		    ImGui::NextColumn();
		    ImGui::TextColored(ImColor(212, 54, 14), "Emote: ");
			    
                    ImGui::Checkbox("AK LV7", &ak);
		    ImGui::SameLine();

                            ImGui::Checkbox("M1887 LV7", &m1887);
		    ImGui::SameLine();
                            ImGui::Checkbox("SCAR LV7", &scar);

                            ImGui::Checkbox("MP40 LV7", &mp);
		    ImGui::SameLine();
                            ImGui::Checkbox("M1014 LV7", &m1014);

                            ImGui::Checkbox("UMP LV7", &ump);
		    ImGui::NextColumn();
		apiClient = [[APIClient alloc] init];

		    ImGui::TextColored(ImColor(255, 1, 1), "Key: %s", [[apiClient getKey] UTF8String]);
		    ImGui::TextColored(ImColor(255, 1, 1), "Expiry: %s", [[apiClient getExpiryDate] UTF8String]);
		    ImGui::NextColumn();
		    ImGui::TextColored(ImColor(255, 1, 1), "MELHOR PAINEL DO MUNDO YOWXIOS");
		    ImGui::TextColored(ImColor(255, 1, 1), u8"contact 🛒 Instagram: @yowxios");
			
	          
	}
}

//chuc nang
ImGuiStyle& style = ImGui::GetStyle();

// Thiết lập giao diện người dùng trong suốt
style.Colors[ImGuiCol_WindowBg].w = 0.9f;  // Đặt mức độ đục của nền cửa sổ thành 0 (suốt)

// Thiết lập bo tròn
style.FrameRounding = 15.0f;
style.GrabMinSize = 7.0f;
style.PopupRounding = 2.0f;
style.ScrollbarRounding = 13.0f;
style.ScrollbarSize = 20.0f;
style.TabBorderSize = 0.6f;
style.TabRounding = 6.0f;
style.WindowRounding = 15.0f;
style.Alpha = 1.0f;  

if (fake)
{
static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{
JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x200000000};
        float search = 5.5;
        engine.JRScanMemory(range, &search, JR_Search_Type_Float); 
        float search1 = 0.75;
        engine.JRScanMemory(range, &search1, JR_Search_Type_Float); 
        vector<void*>results = engine.getAllResults();
        float modify = 9999999;
        for(int i =0;i<results.size();i++){
        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
  }   
 });
}

         if (a1) 
         {
            static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{
                    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                    AddrRange range = (AddrRange){0x1000000,0x20000000000};
                    uint32_t search = 1057048494;
                    engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
                    uint32_t search1 = 1054951342;
                    engine.JRNearBySearch(0x100, &search1, JR_Search_Type_UInt); 
                    uint32_t search2 = 1053273620;
                    engine.JRNearBySearch(0x100, &search2, JR_Search_Type_UInt); 
                    vector<void*>results = engine.getAllResults();
                    uint32_t modify = -2000;
                    for(int i =0;i<results.size();i++)
                    {
                       engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                    }
                });
                                            
        
         }
        if (a2) 
         {
            static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{
                    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                    AddrRange range = (AddrRange){0x0,0x20000000000};
                    float search = 0.09;
                    engine.JRScanMemory(range, &search, JR_Search_Type_Float);
                    vector<void*>results = engine.getAllResults();
                    float modify = 180;
                    for(int i =0;i<results.size();i++)
                    {
                       engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                    }
                });
                                            
        
         }

if (norecoil) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x20000000000};
                uint32_t search = 1016018816;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 6018816;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }
if (cu)
        {
            static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{
                    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                    AddrRange range = (AddrRange){0x10000,0x20000000000};
                    uint32_t search = 96688289;
                    engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                    vector<void*>results = engine.getAllResults();
                    uint32_t modify = 2018908708;
                    for(int i =0;i<results.size();i++){
                    engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);    
                         }
                });
        }
if (antena)
        {
            static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{
                    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        float search = 3.2404066e-7F;
        engine.JRScanMemory(range, &search, JR_Search_Type_Float);
        float search1 = 1;
        engine.JRNearBySearch(0x20, &search1, JR_Search_Type_Float);
        float search2 = 1;
        engine.JRScanMemory(range, &search2, JR_Search_Type_Float);
       float search3 = -0.39830258489F;
        engine.JRScanMemory(range, &search3, JR_Search_Type_Float);
        float search4 = 1;
        engine.JRNearBySearch(0x20, &search4, JR_Search_Type_Float); 
        float search5 = 1;
        engine.JRScanMemory(range, &search5, JR_Search_Type_Float); 
        vector<void*>results = engine.getAllResults();
        float modify = 200;
        for(int i =0;i<results.size();i++){
        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
}
                });
        }

//mod hd
//ak
if (ak) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x200000000};
                uint32_t search = 909000077;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 909000063;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }
if (m1887) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x200000000};
                uint32_t search = 909000060;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 909035007;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }
if (scar) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x200000000};
                uint32_t search = 909000139;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 909000068;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }
if (mp) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x200000000};
                uint32_t search = 909000076;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 909000075;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }
if (m1014) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x200000000};
                uint32_t search = 909000051;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 909000081;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }
if (ump) 
         {
                static dispatch_once_t onceToken;
               dispatch_once(&onceToken, ^{

                JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                AddrRange range = (AddrRange){0x1000000,0x200000000};
                uint32_t search = 909000009;
                engine.JRScanMemory(range, &search, JR_Search_Type_UInt); 
                vector<void*>results = engine.getAllResults();
                uint32_t modify = 909000098;
                for(int i =0;i<results.size();i++)
                {
                 engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                }
                 });
         }


            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}


@end
