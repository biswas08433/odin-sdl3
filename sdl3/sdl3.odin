package sdl3


AssertState :: enum u32 {
	ASSERTION_RETRY         = 0,
	ASSERTION_BREAK         = 1,
	ASSERTION_ABORT         = 2,
	ASSERTION_IGNORE        = 3,
	ASSERTION_ALWAYS_IGNORE = 4,
}
AssertData :: struct {
	always_ignore: b8,
	trigger_count: u32,
	condition:     cstring,
	filename:      cstring,
	linenum:       i32,
	function:      cstring,
	next:          ^AssertData,
}
AssertionHandler :: #type proc "c" (data: ^AssertData, userdata: rawptr) -> AssertState
SpinLock :: i32
AtomicInt :: struct {
	value: i32,
}
AtomicU32 :: struct {
	value: u32,
}
PropertiesID :: u32
PropertyType :: enum u32 {
	PROPERTY_TYPE_INVALID = 0,
	PROPERTY_TYPE_POINTER = 1,
	PROPERTY_TYPE_STRING  = 2,
	PROPERTY_TYPE_NUMBER  = 3,
	PROPERTY_TYPE_FLOAT   = 4,
	PROPERTY_TYPE_BOOLEAN = 5,
}
CleanupPropertyCallback :: #type proc "c" (userdata: rawptr, value: rawptr)
EnumeratePropertiesCallback :: #type proc "c" (
	userdata: rawptr,
	props: PropertiesID,
	name: cstring,
)
Thread :: rawptr
ThreadID :: u64
TLSID :: AtomicInt
ThreadPriority :: enum u32 {
	THREAD_PRIORITY_LOW           = 0,
	THREAD_PRIORITY_NORMAL        = 1,
	THREAD_PRIORITY_HIGH          = 2,
	THREAD_PRIORITY_TIME_CRITICAL = 3,
}
ThreadFunction :: #type proc "c" (data: rawptr) -> i32
TLSDestructorCallback :: #type proc "c" (value: rawptr)
Mutex :: rawptr
RWLock :: rawptr
Semaphore :: rawptr
Condition :: rawptr
InitStatus :: enum u32 {
	INIT_STATUS_UNINITIALIZED  = 0,
	INIT_STATUS_INITIALIZING   = 1,
	INIT_STATUS_INITIALIZED    = 2,
	INIT_STATUS_UNINITIALIZING = 3,
}
InitState :: struct {
	status:   AtomicInt,
	thread:   ThreadID,
	reserved: rawptr,
}
IOStatus :: enum u32 {
	IO_STATUS_READY     = 0,
	IO_STATUS_ERROR     = 1,
	IO_STATUS_EOF       = 2,
	IO_STATUS_NOT_READY = 3,
	IO_STATUS_READONLY  = 4,
	IO_STATUS_WRITEONLY = 5,
}
IOWhence :: enum u32 {
	IO_SEEK_SET = 0,
	IO_SEEK_CUR = 1,
	IO_SEEK_END = 2,
}
size_func_ptr_anon_1 :: #type proc "c" (userdata: rawptr) -> i64
seek_func_ptr_anon_2 :: #type proc "c" (userdata: rawptr, offset: i64, whence: IOWhence) -> i64
read_func_ptr_anon_3 :: #type proc "c" (
	userdata: rawptr,
	ptr: rawptr,
	size: u64,
	status: [^]IOStatus,
) -> u64
write_func_ptr_anon_4 :: #type proc "c" (
	userdata: rawptr,
	ptr: rawptr,
	size: u64,
	status: [^]IOStatus,
) -> u64
flush_func_ptr_anon_5 :: #type proc "c" (userdata: rawptr, status: [^]IOStatus) -> b8
close_func_ptr_anon_6 :: #type proc "c" (userdata: rawptr) -> b8
IOStreamInterface :: struct {
	version: u32,
	size:    size_func_ptr_anon_1,
	seek:    seek_func_ptr_anon_2,
	read:    read_func_ptr_anon_3,
	write:   write_func_ptr_anon_4,
	flush:   flush_func_ptr_anon_5,
	close:   close_func_ptr_anon_6,
}
IOStream :: rawptr
AudioFormat :: enum u32 {
	AUDIO_UNKNOWN = 0,
	AUDIO_U8      = 8,
	AUDIO_S8      = 32776,
	AUDIO_S16LE   = 32784,
	AUDIO_S16BE   = 36880,
	AUDIO_S32LE   = 32800,
	AUDIO_S32BE   = 36896,
	AUDIO_F32LE   = 33056,
	AUDIO_F32BE   = 37152,
	AUDIO_S16     = 32784,
	AUDIO_S32     = 32800,
	AUDIO_F32     = 33056,
}
AudioDeviceID :: u32
AudioSpec :: struct {
	format:   AudioFormat,
	channels: i32,
	freq:     i32,
}
AudioStream :: rawptr
AudioStreamCallback :: #type proc "c" (
	userdata: rawptr,
	stream: AudioStream,
	additional_amount: i32,
	total_amount: i32,
)
AudioPostmixCallback :: #type proc "c" (
	userdata: rawptr,
	spec: ^AudioSpec,
	buffer: ^f32,
	buflen: i32,
)
BlendMode :: u32
BlendOperation :: enum u32 {
	BLENDOPERATION_ADD          = 1,
	BLENDOPERATION_SUBTRACT     = 2,
	BLENDOPERATION_REV_SUBTRACT = 3,
	BLENDOPERATION_MINIMUM      = 4,
	BLENDOPERATION_MAXIMUM      = 5,
}
BlendFactor :: enum u32 {
	BLENDFACTOR_ZERO                = 1,
	BLENDFACTOR_ONE                 = 2,
	BLENDFACTOR_SRC_COLOR           = 3,
	BLENDFACTOR_ONE_MINUS_SRC_COLOR = 4,
	BLENDFACTOR_SRC_ALPHA           = 5,
	BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 6,
	BLENDFACTOR_DST_COLOR           = 7,
	BLENDFACTOR_ONE_MINUS_DST_COLOR = 8,
	BLENDFACTOR_DST_ALPHA           = 9,
	BLENDFACTOR_ONE_MINUS_DST_ALPHA = 10,
}
PixelType :: enum u32 {
	PIXELTYPE_UNKNOWN  = 0,
	PIXELTYPE_INDEX1   = 1,
	PIXELTYPE_INDEX4   = 2,
	PIXELTYPE_INDEX8   = 3,
	PIXELTYPE_PACKED8  = 4,
	PIXELTYPE_PACKED16 = 5,
	PIXELTYPE_PACKED32 = 6,
	PIXELTYPE_ARRAYU8  = 7,
	PIXELTYPE_ARRAYU16 = 8,
	PIXELTYPE_ARRAYU32 = 9,
	PIXELTYPE_ARRAYF16 = 10,
	PIXELTYPE_ARRAYF32 = 11,
	PIXELTYPE_INDEX2   = 12,
}
BitmapOrder :: enum u32 {
	BITMAPORDER_NONE = 0,
	BITMAPORDER_4321 = 1,
	BITMAPORDER_1234 = 2,
}
PackedOrder :: enum u32 {
	PACKEDORDER_NONE = 0,
	PACKEDORDER_XRGB = 1,
	PACKEDORDER_RGBX = 2,
	PACKEDORDER_ARGB = 3,
	PACKEDORDER_RGBA = 4,
	PACKEDORDER_XBGR = 5,
	PACKEDORDER_BGRX = 6,
	PACKEDORDER_ABGR = 7,
	PACKEDORDER_BGRA = 8,
}
ArrayOrder :: enum u32 {
	ARRAYORDER_NONE = 0,
	ARRAYORDER_RGB  = 1,
	ARRAYORDER_RGBA = 2,
	ARRAYORDER_ARGB = 3,
	ARRAYORDER_BGR  = 4,
	ARRAYORDER_BGRA = 5,
	ARRAYORDER_ABGR = 6,
}
PackedLayout :: enum u32 {
	PACKEDLAYOUT_NONE    = 0,
	PACKEDLAYOUT_332     = 1,
	PACKEDLAYOUT_4444    = 2,
	PACKEDLAYOUT_1555    = 3,
	PACKEDLAYOUT_5551    = 4,
	PACKEDLAYOUT_565     = 5,
	PACKEDLAYOUT_8888    = 6,
	PACKEDLAYOUT_2101010 = 7,
	PACKEDLAYOUT_1010102 = 8,
}
PixelFormat :: enum u32 {
	PIXELFORMAT_UNKNOWN       = 0,
	PIXELFORMAT_INDEX1LSB     = 286261504,
	PIXELFORMAT_INDEX1MSB     = 287310080,
	PIXELFORMAT_INDEX2LSB     = 470811136,
	PIXELFORMAT_INDEX2MSB     = 471859712,
	PIXELFORMAT_INDEX4LSB     = 303039488,
	PIXELFORMAT_INDEX4MSB     = 304088064,
	PIXELFORMAT_INDEX8        = 318769153,
	PIXELFORMAT_RGB332        = 336660481,
	PIXELFORMAT_XRGB4444      = 353504258,
	PIXELFORMAT_XBGR4444      = 357698562,
	PIXELFORMAT_XRGB1555      = 353570562,
	PIXELFORMAT_XBGR1555      = 357764866,
	PIXELFORMAT_ARGB4444      = 355602434,
	PIXELFORMAT_RGBA4444      = 356651010,
	PIXELFORMAT_ABGR4444      = 359796738,
	PIXELFORMAT_BGRA4444      = 360845314,
	PIXELFORMAT_ARGB1555      = 355667970,
	PIXELFORMAT_RGBA5551      = 356782082,
	PIXELFORMAT_ABGR1555      = 359862274,
	PIXELFORMAT_BGRA5551      = 360976386,
	PIXELFORMAT_RGB565        = 353701890,
	PIXELFORMAT_BGR565        = 357896194,
	PIXELFORMAT_RGB24         = 386930691,
	PIXELFORMAT_BGR24         = 390076419,
	PIXELFORMAT_XRGB8888      = 370546692,
	PIXELFORMAT_RGBX8888      = 371595268,
	PIXELFORMAT_XBGR8888      = 374740996,
	PIXELFORMAT_BGRX8888      = 375789572,
	PIXELFORMAT_ARGB8888      = 372645892,
	PIXELFORMAT_RGBA8888      = 373694468,
	PIXELFORMAT_ABGR8888      = 376840196,
	PIXELFORMAT_BGRA8888      = 377888772,
	PIXELFORMAT_XRGB2101010   = 370614276,
	PIXELFORMAT_XBGR2101010   = 374808580,
	PIXELFORMAT_ARGB2101010   = 372711428,
	PIXELFORMAT_ABGR2101010   = 376905732,
	PIXELFORMAT_RGB48         = 403714054,
	PIXELFORMAT_BGR48         = 406859782,
	PIXELFORMAT_RGBA64        = 404766728,
	PIXELFORMAT_ARGB64        = 405815304,
	PIXELFORMAT_BGRA64        = 407912456,
	PIXELFORMAT_ABGR64        = 408961032,
	PIXELFORMAT_RGB48_FLOAT   = 437268486,
	PIXELFORMAT_BGR48_FLOAT   = 440414214,
	PIXELFORMAT_RGBA64_FLOAT  = 438321160,
	PIXELFORMAT_ARGB64_FLOAT  = 439369736,
	PIXELFORMAT_BGRA64_FLOAT  = 441466888,
	PIXELFORMAT_ABGR64_FLOAT  = 442515464,
	PIXELFORMAT_RGB96_FLOAT   = 454057996,
	PIXELFORMAT_BGR96_FLOAT   = 457203724,
	PIXELFORMAT_RGBA128_FLOAT = 455114768,
	PIXELFORMAT_ARGB128_FLOAT = 456163344,
	PIXELFORMAT_BGRA128_FLOAT = 458260496,
	PIXELFORMAT_ABGR128_FLOAT = 459309072,
	PIXELFORMAT_YV12          = 842094169,
	PIXELFORMAT_IYUV          = 1448433993,
	PIXELFORMAT_YUY2          = 844715353,
	PIXELFORMAT_UYVY          = 1498831189,
	PIXELFORMAT_YVYU          = 1431918169,
	PIXELFORMAT_NV12          = 842094158,
	PIXELFORMAT_NV21          = 825382478,
	PIXELFORMAT_P010          = 808530000,
	PIXELFORMAT_EXTERNAL_OES  = 542328143,
	PIXELFORMAT_RGBA32        = 376840196,
	PIXELFORMAT_ARGB32        = 377888772,
	PIXELFORMAT_BGRA32        = 372645892,
	PIXELFORMAT_ABGR32        = 373694468,
	PIXELFORMAT_RGBX32        = 374740996,
	PIXELFORMAT_XRGB32        = 375789572,
	PIXELFORMAT_BGRX32        = 370546692,
	PIXELFORMAT_XBGR32        = 371595268,
}
ColorType :: enum u32 {
	COLOR_TYPE_UNKNOWN = 0,
	COLOR_TYPE_RGB     = 1,
	COLOR_TYPE_YCBCR   = 2,
}
ColorRange :: enum u32 {
	COLOR_RANGE_UNKNOWN = 0,
	COLOR_RANGE_LIMITED = 1,
	COLOR_RANGE_FULL    = 2,
}
ColorPrimaries :: enum u32 {
	COLOR_PRIMARIES_UNKNOWN      = 0,
	COLOR_PRIMARIES_BT709        = 1,
	COLOR_PRIMARIES_UNSPECIFIED  = 2,
	COLOR_PRIMARIES_BT470M       = 4,
	COLOR_PRIMARIES_BT470BG      = 5,
	COLOR_PRIMARIES_BT601        = 6,
	COLOR_PRIMARIES_SMPTE240     = 7,
	COLOR_PRIMARIES_GENERIC_FILM = 8,
	COLOR_PRIMARIES_BT2020       = 9,
	COLOR_PRIMARIES_XYZ          = 10,
	COLOR_PRIMARIES_SMPTE431     = 11,
	COLOR_PRIMARIES_SMPTE432     = 12,
	COLOR_PRIMARIES_EBU3213      = 22,
	COLOR_PRIMARIES_CUSTOM       = 31,
}
TransferCharacteristics :: enum u32 {
	TRANSFER_CHARACTERISTICS_UNKNOWN       = 0,
	TRANSFER_CHARACTERISTICS_BT709         = 1,
	TRANSFER_CHARACTERISTICS_UNSPECIFIED   = 2,
	TRANSFER_CHARACTERISTICS_GAMMA22       = 4,
	TRANSFER_CHARACTERISTICS_GAMMA28       = 5,
	TRANSFER_CHARACTERISTICS_BT601         = 6,
	TRANSFER_CHARACTERISTICS_SMPTE240      = 7,
	TRANSFER_CHARACTERISTICS_LINEAR        = 8,
	TRANSFER_CHARACTERISTICS_LOG100        = 9,
	TRANSFER_CHARACTERISTICS_LOG100_SQRT10 = 10,
	TRANSFER_CHARACTERISTICS_IEC61966      = 11,
	TRANSFER_CHARACTERISTICS_BT1361        = 12,
	TRANSFER_CHARACTERISTICS_SRGB          = 13,
	TRANSFER_CHARACTERISTICS_BT2020_10BIT  = 14,
	TRANSFER_CHARACTERISTICS_BT2020_12BIT  = 15,
	TRANSFER_CHARACTERISTICS_PQ            = 16,
	TRANSFER_CHARACTERISTICS_SMPTE428      = 17,
	TRANSFER_CHARACTERISTICS_HLG           = 18,
	TRANSFER_CHARACTERISTICS_CUSTOM        = 31,
}
MatrixCoefficients :: enum u32 {
	MATRIX_COEFFICIENTS_IDENTITY           = 0,
	MATRIX_COEFFICIENTS_BT709              = 1,
	MATRIX_COEFFICIENTS_UNSPECIFIED        = 2,
	MATRIX_COEFFICIENTS_FCC                = 4,
	MATRIX_COEFFICIENTS_BT470BG            = 5,
	MATRIX_COEFFICIENTS_BT601              = 6,
	MATRIX_COEFFICIENTS_SMPTE240           = 7,
	MATRIX_COEFFICIENTS_YCGCO              = 8,
	MATRIX_COEFFICIENTS_BT2020_NCL         = 9,
	MATRIX_COEFFICIENTS_BT2020_CL          = 10,
	MATRIX_COEFFICIENTS_SMPTE2085          = 11,
	MATRIX_COEFFICIENTS_CHROMA_DERIVED_NCL = 12,
	MATRIX_COEFFICIENTS_CHROMA_DERIVED_CL  = 13,
	MATRIX_COEFFICIENTS_ICTCP              = 14,
	MATRIX_COEFFICIENTS_CUSTOM             = 31,
}
ChromaLocation :: enum u32 {
	CHROMA_LOCATION_NONE    = 0,
	CHROMA_LOCATION_LEFT    = 1,
	CHROMA_LOCATION_CENTER  = 2,
	CHROMA_LOCATION_TOPLEFT = 3,
}
Colorspace :: enum u32 {
	COLORSPACE_UNKNOWN        = 0,
	COLORSPACE_SRGB           = 301991328,
	COLORSPACE_SRGB_LINEAR    = 301991168,
	COLORSPACE_HDR10          = 301999616,
	COLORSPACE_JPEG           = 570426566,
	COLORSPACE_BT601_LIMITED  = 554703046,
	COLORSPACE_BT601_FULL     = 571480262,
	COLORSPACE_BT709_LIMITED  = 554697761,
	COLORSPACE_BT709_FULL     = 571474977,
	COLORSPACE_BT2020_LIMITED = 554706441,
	COLORSPACE_BT2020_FULL    = 571483657,
	COLORSPACE_RGB_DEFAULT    = 301991328,
	COLORSPACE_YUV_DEFAULT    = 570426566,
}
Color :: struct {
	r: u8,
	g: u8,
	b: u8,
	a: u8,
}
FColor :: struct {
	r: f32,
	g: f32,
	b: f32,
	a: f32,
}
Palette :: struct {
	ncolors:  i32,
	colors:   [^]Color,
	version:  u32,
	refcount: i32,
}
PixelFormatDetails :: struct {
	format:          PixelFormat,
	bits_per_pixel:  u8,
	bytes_per_pixel: u8,
	padding:         [2]u8,
	Rmask:           u32,
	Gmask:           u32,
	Bmask:           u32,
	Amask:           u32,
	Rbits:           u8,
	Gbits:           u8,
	Bbits:           u8,
	Abits:           u8,
	Rshift:          u8,
	Gshift:          u8,
	Bshift:          u8,
	Ashift:          u8,
}
Point :: struct {
	x: i32,
	y: i32,
}
FPoint :: struct {
	x: f32,
	y: f32,
}
Rect :: struct {
	x: i32,
	y: i32,
	w: i32,
	h: i32,
}
FRect :: struct {
	x: f32,
	y: f32,
	w: f32,
	h: f32,
}
SurfaceFlags :: u32
ScaleMode :: enum u32 {
	SCALEMODE_NEAREST = 0,
	SCALEMODE_LINEAR  = 1,
}
FlipMode :: enum u32 {
	FLIP_NONE       = 0,
	FLIP_HORIZONTAL = 1,
	FLIP_VERTICAL   = 2,
}
Surface :: struct {
	flags:    SurfaceFlags,
	format:   PixelFormat,
	w:        i32,
	h:        i32,
	pitch:    i32,
	pixels:   rawptr,
	refcount: i32,
	reserved: rawptr,
}
CameraID :: u32
Camera :: rawptr
CameraSpec :: struct {
	format:                PixelFormat,
	colorspace:            Colorspace,
	width:                 i32,
	height:                i32,
	framerate_numerator:   i32,
	framerate_denominator: i32,
}
CameraPosition :: enum u32 {
	CAMERA_POSITION_UNKNOWN      = 0,
	CAMERA_POSITION_FRONT_FACING = 1,
	CAMERA_POSITION_BACK_FACING  = 2,
}
ClipboardDataCallback :: #type proc "c" (
	userdata: rawptr,
	mime_type: cstring,
	size: ^u64,
) -> rawptr
ClipboardCleanupCallback :: #type proc "c" (userdata: rawptr)
DisplayID :: u32
WindowID :: u32
SystemTheme :: enum u32 {
	SYSTEM_THEME_UNKNOWN = 0,
	SYSTEM_THEME_LIGHT   = 1,
	SYSTEM_THEME_DARK    = 2,
}
DisplayModeData :: rawptr
DisplayMode :: struct {
	displayID:                DisplayID,
	format:                   PixelFormat,
	w:                        i32,
	h:                        i32,
	pixel_density:            f32,
	refresh_rate:             f32,
	refresh_rate_numerator:   i32,
	refresh_rate_denominator: i32,
	internal:                 DisplayModeData,
}
DisplayOrientation :: enum u32 {
	ORIENTATION_UNKNOWN           = 0,
	ORIENTATION_LANDSCAPE         = 1,
	ORIENTATION_LANDSCAPE_FLIPPED = 2,
	ORIENTATION_PORTRAIT          = 3,
	ORIENTATION_PORTRAIT_FLIPPED  = 4,
}

Window :: rawptr
WindowFlags :: u64
WINDOW_FULLSCREEN :: 0x0000000000000001 /**< window is in fullscreen mode */
WINDOW_OPENGL :: 0x0000000000000002 /**< window usable with OpenGL context */
WINDOW_OCCLUDED :: 0x0000000000000004 /**< window is occluded */
WINDOW_HIDDEN :: 0x0000000000000008 /**< window is neither mapped onto the desktop nor shown in the taskbar/dock/window list; SDL_ShowWindow)is required for it to become visible */
WINDOW_BORDERLESS :: 0x0000000000000010 /**< no window decoration */
WINDOW_RESIZABLE :: 0x0000000000000020 /**< window can be resized */
WINDOW_MINIMIZED :: 0x0000000000000040 /**< window is minimized */
WINDOW_MAXIMIZED :: 0x0000000000000080 /**< window is maximized */
WINDOW_MOUSE_GRABBED :: 0x0000000000000100 /**< window has grabbed mouse input */
WINDOW_INPUT_FOCUS :: 0x0000000000000200 /**< window has input focus */
WINDOW_MOUSE_FOCUS :: 0x0000000000000400 /**< window has mouse focus */
WINDOW_EXTERNAL :: 0x0000000000000800 /**< window not created by SDL */
WINDOW_MODAL :: 0x0000000000001000 /**< window is modal */
WINDOW_HIGH_PIXEL_DENSITY :: 0x0000000000002000 /**< window uses high pixel density back buffer if possible */
WINDOW_MOUSE_CAPTURE :: 0x0000000000004000 /**< window has mouse captured unrelatedto MOUSE_GRABBED) */
WINDOW_MOUSE_RELATIVE_MODE :: 0x0000000000008000 /**< window has relative mode enabled */
WINDOW_ALWAYS_ON_TOP :: 0x0000000000010000 /**< window should always be above others */
WINDOW_UTILITY :: 0x0000000000020000 /**< window should be treated as a utility window, not showing in the task bar and window list */
WINDOW_TOOLTIP :: 0x0000000000040000 /**< window should be treated as a tooltip and does not get mouse or keyboard focus, requires a parent window */
WINDOW_POPUP_MENU :: 0x0000000000080000 /**< window should be treated as a popup menu, requires a parent window */
WINDOW_KEYBOARD_GRABBED :: 0x0000000000100000 /**< window has grabbed keyboard input */
WINDOW_VULKAN :: 0x0000000010000000 /**< window usable for Vulkan surface */
WINDOW_METAL :: 0x0000000020000000 /**< window usable for Metal view */
WINDOW_TRANSPARENT :: 0x0000000040000000 /**< window with transparent buffer */
WINDOW_NOT_FOCUSABLE :: 0x0000000080000000 /**< window should not be focusable */

FlashOperation :: enum u32 {
	FLASH_CANCEL        = 0,
	FLASH_BRIEFLY       = 1,
	FLASH_UNTIL_FOCUSED = 2,
}
GLContextState :: rawptr
GLContext :: GLContextState
EGLDisplay :: rawptr
EGLConfig :: rawptr
EGLSurface :: rawptr
EGLAttrib :: i64
EGLint :: i32
EGLAttribArrayCallback :: #type proc "c" (userdata: rawptr) -> EGLAttrib
EGLIntArrayCallback :: #type proc "c" (
	userdata: rawptr,
	display: EGLDisplay,
	config: EGLConfig,
) -> ^EGLint
GLAttr :: enum u32 {
	GL_RED_SIZE                   = 0,
	GL_GREEN_SIZE                 = 1,
	GL_BLUE_SIZE                  = 2,
	GL_ALPHA_SIZE                 = 3,
	GL_BUFFER_SIZE                = 4,
	GL_DOUBLEBUFFER               = 5,
	GL_DEPTH_SIZE                 = 6,
	GL_STENCIL_SIZE               = 7,
	GL_ACCUM_RED_SIZE             = 8,
	GL_ACCUM_GREEN_SIZE           = 9,
	GL_ACCUM_BLUE_SIZE            = 10,
	GL_ACCUM_ALPHA_SIZE           = 11,
	GL_STEREO                     = 12,
	GL_MULTISAMPLEBUFFERS         = 13,
	GL_MULTISAMPLESAMPLES         = 14,
	GL_ACCELERATED_VISUAL         = 15,
	GL_RETAINED_BACKING           = 16,
	GL_CONTEXT_MAJOR_VERSION      = 17,
	GL_CONTEXT_MINOR_VERSION      = 18,
	GL_CONTEXT_FLAGS              = 19,
	GL_CONTEXT_PROFILE_MASK       = 20,
	GL_SHARE_WITH_CURRENT_CONTEXT = 21,
	GL_FRAMEBUFFER_SRGB_CAPABLE   = 22,
	GL_CONTEXT_RELEASE_BEHAVIOR   = 23,
	GL_CONTEXT_RESET_NOTIFICATION = 24,
	GL_CONTEXT_NO_ERROR           = 25,
	GL_FLOATBUFFERS               = 26,
	GL_EGL_PLATFORM               = 27,
}
GLProfile :: u32
GLContextFlag :: u32
GLContextReleaseFlag :: u32
GLContextResetNotification :: u32
HitTestResult :: enum u32 {
	HITTEST_NORMAL             = 0,
	HITTEST_DRAGGABLE          = 1,
	HITTEST_RESIZE_TOPLEFT     = 2,
	HITTEST_RESIZE_TOP         = 3,
	HITTEST_RESIZE_TOPRIGHT    = 4,
	HITTEST_RESIZE_RIGHT       = 5,
	HITTEST_RESIZE_BOTTOMRIGHT = 6,
	HITTEST_RESIZE_BOTTOM      = 7,
	HITTEST_RESIZE_BOTTOMLEFT  = 8,
	HITTEST_RESIZE_LEFT        = 9,
}
HitTest :: #type proc "c" (win: Window, area: ^Point, data: rawptr) -> HitTestResult
DialogFileFilter :: struct {
	name:    cstring,
	pattern: cstring,
}
DialogFileCallback :: #type proc "c" (userdata: rawptr, filelist: ^cstring, filter: i32)
GUID :: struct {
	data: [16]u8,
}
PowerState :: enum i32 {
	POWERSTATE_ERROR      = -1,
	POWERSTATE_UNKNOWN    = 0,
	POWERSTATE_ON_BATTERY = 1,
	POWERSTATE_NO_BATTERY = 2,
	POWERSTATE_CHARGING   = 3,
	POWERSTATE_CHARGED    = 4,
}
Sensor :: rawptr
SensorID :: u32
SensorType :: enum i32 {
	SENSOR_INVALID = -1,
	SENSOR_UNKNOWN = 0,
	SENSOR_ACCEL   = 1,
	SENSOR_GYRO    = 2,
	SENSOR_ACCEL_L = 3,
	SENSOR_GYRO_L  = 4,
	SENSOR_ACCEL_R = 5,
	SENSOR_GYRO_R  = 6,
}
Joystick :: rawptr
JoystickID :: u32
JoystickType :: enum u32 {
	JOYSTICK_TYPE_UNKNOWN      = 0,
	JOYSTICK_TYPE_GAMEPAD      = 1,
	JOYSTICK_TYPE_WHEEL        = 2,
	JOYSTICK_TYPE_ARCADE_STICK = 3,
	JOYSTICK_TYPE_FLIGHT_STICK = 4,
	JOYSTICK_TYPE_DANCE_PAD    = 5,
	JOYSTICK_TYPE_GUITAR       = 6,
	JOYSTICK_TYPE_DRUM_KIT     = 7,
	JOYSTICK_TYPE_ARCADE_PAD   = 8,
	JOYSTICK_TYPE_THROTTLE     = 9,
	JOYSTICK_TYPE_COUNT        = 10,
}
JoystickConnectionState :: enum i32 {
	JOYSTICK_CONNECTION_INVALID  = -1,
	JOYSTICK_CONNECTION_UNKNOWN  = 0,
	JOYSTICK_CONNECTION_WIRED    = 1,
	JOYSTICK_CONNECTION_WIRELESS = 2,
}
VirtualJoystickTouchpadDesc :: struct {
	nfingers: u16,
	padding:  [3]u16,
}
VirtualJoystickSensorDesc :: struct {
	type: SensorType,
	rate: f32,
}
Update_func_ptr_anon_7 :: #type proc "c" (userdata: rawptr)
SetPlayerIndex_func_ptr_anon_8 :: #type proc "c" (userdata: rawptr, player_index: i32)
Rumble_func_ptr_anon_9 :: #type proc "c" (
	userdata: rawptr,
	low_frequency_rumble: u16,
	high_frequency_rumble: u16,
) -> b8
RumbleTriggers_func_ptr_anon_10 :: #type proc "c" (
	userdata: rawptr,
	left_rumble: u16,
	right_rumble: u16,
) -> b8
SetLED_func_ptr_anon_11 :: #type proc "c" (userdata: rawptr, red: u8, green: u8, blue: u8) -> b8
SendEffect_func_ptr_anon_12 :: #type proc "c" (userdata: rawptr, data: rawptr, size: i32) -> b8
SetSensorsEnabled_func_ptr_anon_13 :: #type proc "c" (userdata: rawptr, enabled: b8) -> b8
Cleanup_func_ptr_anon_14 :: #type proc "c" (userdata: rawptr)
VirtualJoystickDesc :: struct {
	version:           u32,
	type:              u16,
	padding:           u16,
	vendor_id:         u16,
	product_id:        u16,
	naxes:             u16,
	nbuttons:          u16,
	nballs:            u16,
	nhats:             u16,
	ntouchpads:        u16,
	nsensors:          u16,
	padding2:          [2]u16,
	button_mask:       u32,
	axis_mask:         u32,
	name:              cstring,
	touchpads:         [^]VirtualJoystickTouchpadDesc,
	sensors:           [^]VirtualJoystickSensorDesc,
	userdata:          rawptr,
	Update:            Update_func_ptr_anon_7,
	SetPlayerIndex:    SetPlayerIndex_func_ptr_anon_8,
	Rumble:            Rumble_func_ptr_anon_9,
	RumbleTriggers:    RumbleTriggers_func_ptr_anon_10,
	SetLED:            SetLED_func_ptr_anon_11,
	SendEffect:        SendEffect_func_ptr_anon_12,
	SetSensorsEnabled: SetSensorsEnabled_func_ptr_anon_13,
	Cleanup:           Cleanup_func_ptr_anon_14,
}
Gamepad :: rawptr
GamepadType :: enum u32 {
	GAMEPAD_TYPE_UNKNOWN                      = 0,
	GAMEPAD_TYPE_STANDARD                     = 1,
	GAMEPAD_TYPE_XBOX360                      = 2,
	GAMEPAD_TYPE_XBOXONE                      = 3,
	GAMEPAD_TYPE_PS3                          = 4,
	GAMEPAD_TYPE_PS4                          = 5,
	GAMEPAD_TYPE_PS5                          = 6,
	GAMEPAD_TYPE_NINTENDO_SWITCH_PRO          = 7,
	GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_LEFT  = 8,
	GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT = 9,
	GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_PAIR  = 10,
	GAMEPAD_TYPE_COUNT                        = 11,
}
GamepadButton :: enum i32 {
	GAMEPAD_BUTTON_INVALID        = -1,
	GAMEPAD_BUTTON_SOUTH          = 0,
	GAMEPAD_BUTTON_EAST           = 1,
	GAMEPAD_BUTTON_WEST           = 2,
	GAMEPAD_BUTTON_NORTH          = 3,
	GAMEPAD_BUTTON_BACK           = 4,
	GAMEPAD_BUTTON_GUIDE          = 5,
	GAMEPAD_BUTTON_START          = 6,
	GAMEPAD_BUTTON_LEFT_STICK     = 7,
	GAMEPAD_BUTTON_RIGHT_STICK    = 8,
	GAMEPAD_BUTTON_LEFT_SHOULDER  = 9,
	GAMEPAD_BUTTON_RIGHT_SHOULDER = 10,
	GAMEPAD_BUTTON_DPAD_UP        = 11,
	GAMEPAD_BUTTON_DPAD_DOWN      = 12,
	GAMEPAD_BUTTON_DPAD_LEFT      = 13,
	GAMEPAD_BUTTON_DPAD_RIGHT     = 14,
	GAMEPAD_BUTTON_MISC1          = 15,
	GAMEPAD_BUTTON_RIGHT_PADDLE1  = 16,
	GAMEPAD_BUTTON_LEFT_PADDLE1   = 17,
	GAMEPAD_BUTTON_RIGHT_PADDLE2  = 18,
	GAMEPAD_BUTTON_LEFT_PADDLE2   = 19,
	GAMEPAD_BUTTON_TOUCHPAD       = 20,
	GAMEPAD_BUTTON_MISC2          = 21,
	GAMEPAD_BUTTON_MISC3          = 22,
	GAMEPAD_BUTTON_MISC4          = 23,
	GAMEPAD_BUTTON_MISC5          = 24,
	GAMEPAD_BUTTON_MISC6          = 25,
	GAMEPAD_BUTTON_COUNT          = 26,
}
GamepadButtonLabel :: enum u32 {
	GAMEPAD_BUTTON_LABEL_UNKNOWN  = 0,
	GAMEPAD_BUTTON_LABEL_A        = 1,
	GAMEPAD_BUTTON_LABEL_B        = 2,
	GAMEPAD_BUTTON_LABEL_X        = 3,
	GAMEPAD_BUTTON_LABEL_Y        = 4,
	GAMEPAD_BUTTON_LABEL_CROSS    = 5,
	GAMEPAD_BUTTON_LABEL_CIRCLE   = 6,
	GAMEPAD_BUTTON_LABEL_SQUARE   = 7,
	GAMEPAD_BUTTON_LABEL_TRIANGLE = 8,
}
GamepadAxis :: enum i32 {
	GAMEPAD_AXIS_INVALID       = -1,
	GAMEPAD_AXIS_LEFTX         = 0,
	GAMEPAD_AXIS_LEFTY         = 1,
	GAMEPAD_AXIS_RIGHTX        = 2,
	GAMEPAD_AXIS_RIGHTY        = 3,
	GAMEPAD_AXIS_LEFT_TRIGGER  = 4,
	GAMEPAD_AXIS_RIGHT_TRIGGER = 5,
	GAMEPAD_AXIS_COUNT         = 6,
}
GamepadBindingType :: enum u32 {
	GAMEPAD_BINDTYPE_NONE   = 0,
	GAMEPAD_BINDTYPE_BUTTON = 1,
	GAMEPAD_BINDTYPE_AXIS   = 2,
	GAMEPAD_BINDTYPE_HAT    = 3,
}
axis_struct_anon_15 :: struct {
	axis:     i32,
	axis_min: i32,
	axis_max: i32,
}
hat_struct_anon_16 :: struct {
	hat:      i32,
	hat_mask: i32,
}
input_union_anon_17 :: struct #raw_union {
	button: i32,
	axis:   axis_struct_anon_15,
	hat:    hat_struct_anon_16,
}
axis_struct_anon_18 :: struct {
	axis:     GamepadAxis,
	axis_min: i32,
	axis_max: i32,
}
output_union_anon_19 :: struct #raw_union {
	button: GamepadButton,
	axis:   axis_struct_anon_18,
}
GamepadBinding :: struct {
	input_type:  GamepadBindingType,
	input:       input_union_anon_17,
	output_type: GamepadBindingType,
	output:      output_union_anon_19,
}
Scancode :: enum u32 {
	SCANCODE_UNKNOWN              = 0,
	SCANCODE_A                    = 4,
	SCANCODE_B                    = 5,
	SCANCODE_C                    = 6,
	SCANCODE_D                    = 7,
	SCANCODE_E                    = 8,
	SCANCODE_F                    = 9,
	SCANCODE_G                    = 10,
	SCANCODE_H                    = 11,
	SCANCODE_I                    = 12,
	SCANCODE_J                    = 13,
	SCANCODE_K                    = 14,
	SCANCODE_L                    = 15,
	SCANCODE_M                    = 16,
	SCANCODE_N                    = 17,
	SCANCODE_O                    = 18,
	SCANCODE_P                    = 19,
	SCANCODE_Q                    = 20,
	SCANCODE_R                    = 21,
	SCANCODE_S                    = 22,
	SCANCODE_T                    = 23,
	SCANCODE_U                    = 24,
	SCANCODE_V                    = 25,
	SCANCODE_W                    = 26,
	SCANCODE_X                    = 27,
	SCANCODE_Y                    = 28,
	SCANCODE_Z                    = 29,
	SCANCODE_1                    = 30,
	SCANCODE_2                    = 31,
	SCANCODE_3                    = 32,
	SCANCODE_4                    = 33,
	SCANCODE_5                    = 34,
	SCANCODE_6                    = 35,
	SCANCODE_7                    = 36,
	SCANCODE_8                    = 37,
	SCANCODE_9                    = 38,
	SCANCODE_0                    = 39,
	SCANCODE_RETURN               = 40,
	SCANCODE_ESCAPE               = 41,
	SCANCODE_BACKSPACE            = 42,
	SCANCODE_TAB                  = 43,
	SCANCODE_SPACE                = 44,
	SCANCODE_MINUS                = 45,
	SCANCODE_EQUALS               = 46,
	SCANCODE_LEFTBRACKET          = 47,
	SCANCODE_RIGHTBRACKET         = 48,
	SCANCODE_BACKSLASH            = 49,
	SCANCODE_NONUSHASH            = 50,
	SCANCODE_SEMICOLON            = 51,
	SCANCODE_APOSTROPHE           = 52,
	SCANCODE_GRAVE                = 53,
	SCANCODE_COMMA                = 54,
	SCANCODE_PERIOD               = 55,
	SCANCODE_SLASH                = 56,
	SCANCODE_CAPSLOCK             = 57,
	SCANCODE_F1                   = 58,
	SCANCODE_F2                   = 59,
	SCANCODE_F3                   = 60,
	SCANCODE_F4                   = 61,
	SCANCODE_F5                   = 62,
	SCANCODE_F6                   = 63,
	SCANCODE_F7                   = 64,
	SCANCODE_F8                   = 65,
	SCANCODE_F9                   = 66,
	SCANCODE_F10                  = 67,
	SCANCODE_F11                  = 68,
	SCANCODE_F12                  = 69,
	SCANCODE_PRINTSCREEN          = 70,
	SCANCODE_SCROLLLOCK           = 71,
	SCANCODE_PAUSE                = 72,
	SCANCODE_INSERT               = 73,
	SCANCODE_HOME                 = 74,
	SCANCODE_PAGEUP               = 75,
	SCANCODE_DELETE               = 76,
	SCANCODE_END                  = 77,
	SCANCODE_PAGEDOWN             = 78,
	SCANCODE_RIGHT                = 79,
	SCANCODE_LEFT                 = 80,
	SCANCODE_DOWN                 = 81,
	SCANCODE_UP                   = 82,
	SCANCODE_NUMLOCKCLEAR         = 83,
	SCANCODE_KP_DIVIDE            = 84,
	SCANCODE_KP_MULTIPLY          = 85,
	SCANCODE_KP_MINUS             = 86,
	SCANCODE_KP_PLUS              = 87,
	SCANCODE_KP_ENTER             = 88,
	SCANCODE_KP_1                 = 89,
	SCANCODE_KP_2                 = 90,
	SCANCODE_KP_3                 = 91,
	SCANCODE_KP_4                 = 92,
	SCANCODE_KP_5                 = 93,
	SCANCODE_KP_6                 = 94,
	SCANCODE_KP_7                 = 95,
	SCANCODE_KP_8                 = 96,
	SCANCODE_KP_9                 = 97,
	SCANCODE_KP_0                 = 98,
	SCANCODE_KP_PERIOD            = 99,
	SCANCODE_NONUSBACKSLASH       = 100,
	SCANCODE_APPLICATION          = 101,
	SCANCODE_POWER                = 102,
	SCANCODE_KP_EQUALS            = 103,
	SCANCODE_F13                  = 104,
	SCANCODE_F14                  = 105,
	SCANCODE_F15                  = 106,
	SCANCODE_F16                  = 107,
	SCANCODE_F17                  = 108,
	SCANCODE_F18                  = 109,
	SCANCODE_F19                  = 110,
	SCANCODE_F20                  = 111,
	SCANCODE_F21                  = 112,
	SCANCODE_F22                  = 113,
	SCANCODE_F23                  = 114,
	SCANCODE_F24                  = 115,
	SCANCODE_EXECUTE              = 116,
	SCANCODE_HELP                 = 117,
	SCANCODE_MENU                 = 118,
	SCANCODE_SELECT               = 119,
	SCANCODE_STOP                 = 120,
	SCANCODE_AGAIN                = 121,
	SCANCODE_UNDO                 = 122,
	SCANCODE_CUT                  = 123,
	SCANCODE_COPY                 = 124,
	SCANCODE_PASTE                = 125,
	SCANCODE_FIND                 = 126,
	SCANCODE_MUTE                 = 127,
	SCANCODE_VOLUMEUP             = 128,
	SCANCODE_VOLUMEDOWN           = 129,
	SCANCODE_KP_COMMA             = 133,
	SCANCODE_KP_EQUALSAS400       = 134,
	SCANCODE_INTERNATIONAL1       = 135,
	SCANCODE_INTERNATIONAL2       = 136,
	SCANCODE_INTERNATIONAL3       = 137,
	SCANCODE_INTERNATIONAL4       = 138,
	SCANCODE_INTERNATIONAL5       = 139,
	SCANCODE_INTERNATIONAL6       = 140,
	SCANCODE_INTERNATIONAL7       = 141,
	SCANCODE_INTERNATIONAL8       = 142,
	SCANCODE_INTERNATIONAL9       = 143,
	SCANCODE_LANG1                = 144,
	SCANCODE_LANG2                = 145,
	SCANCODE_LANG3                = 146,
	SCANCODE_LANG4                = 147,
	SCANCODE_LANG5                = 148,
	SCANCODE_LANG6                = 149,
	SCANCODE_LANG7                = 150,
	SCANCODE_LANG8                = 151,
	SCANCODE_LANG9                = 152,
	SCANCODE_ALTERASE             = 153,
	SCANCODE_SYSREQ               = 154,
	SCANCODE_CANCEL               = 155,
	SCANCODE_CLEAR                = 156,
	SCANCODE_PRIOR                = 157,
	SCANCODE_RETURN2              = 158,
	SCANCODE_SEPARATOR            = 159,
	SCANCODE_OUT                  = 160,
	SCANCODE_OPER                 = 161,
	SCANCODE_CLEARAGAIN           = 162,
	SCANCODE_CRSEL                = 163,
	SCANCODE_EXSEL                = 164,
	SCANCODE_KP_00                = 176,
	SCANCODE_KP_000               = 177,
	SCANCODE_THOUSANDSSEPARATOR   = 178,
	SCANCODE_DECIMALSEPARATOR     = 179,
	SCANCODE_CURRENCYUNIT         = 180,
	SCANCODE_CURRENCYSUBUNIT      = 181,
	SCANCODE_KP_LEFTPAREN         = 182,
	SCANCODE_KP_RIGHTPAREN        = 183,
	SCANCODE_KP_LEFTBRACE         = 184,
	SCANCODE_KP_RIGHTBRACE        = 185,
	SCANCODE_KP_TAB               = 186,
	SCANCODE_KP_BACKSPACE         = 187,
	SCANCODE_KP_A                 = 188,
	SCANCODE_KP_B                 = 189,
	SCANCODE_KP_C                 = 190,
	SCANCODE_KP_D                 = 191,
	SCANCODE_KP_E                 = 192,
	SCANCODE_KP_F                 = 193,
	SCANCODE_KP_XOR               = 194,
	SCANCODE_KP_POWER             = 195,
	SCANCODE_KP_PERCENT           = 196,
	SCANCODE_KP_LESS              = 197,
	SCANCODE_KP_GREATER           = 198,
	SCANCODE_KP_AMPERSAND         = 199,
	SCANCODE_KP_DBLAMPERSAND      = 200,
	SCANCODE_KP_VERTICALBAR       = 201,
	SCANCODE_KP_DBLVERTICALBAR    = 202,
	SCANCODE_KP_COLON             = 203,
	SCANCODE_KP_HASH              = 204,
	SCANCODE_KP_SPACE             = 205,
	SCANCODE_KP_AT                = 206,
	SCANCODE_KP_EXCLAM            = 207,
	SCANCODE_KP_MEMSTORE          = 208,
	SCANCODE_KP_MEMRECALL         = 209,
	SCANCODE_KP_MEMCLEAR          = 210,
	SCANCODE_KP_MEMADD            = 211,
	SCANCODE_KP_MEMSUBTRACT       = 212,
	SCANCODE_KP_MEMMULTIPLY       = 213,
	SCANCODE_KP_MEMDIVIDE         = 214,
	SCANCODE_KP_PLUSMINUS         = 215,
	SCANCODE_KP_CLEAR             = 216,
	SCANCODE_KP_CLEARENTRY        = 217,
	SCANCODE_KP_BINARY            = 218,
	SCANCODE_KP_OCTAL             = 219,
	SCANCODE_KP_DECIMAL           = 220,
	SCANCODE_KP_HEXADECIMAL       = 221,
	SCANCODE_LCTRL                = 224,
	SCANCODE_LSHIFT               = 225,
	SCANCODE_LALT                 = 226,
	SCANCODE_LGUI                 = 227,
	SCANCODE_RCTRL                = 228,
	SCANCODE_RSHIFT               = 229,
	SCANCODE_RALT                 = 230,
	SCANCODE_RGUI                 = 231,
	SCANCODE_MODE                 = 257,
	SCANCODE_SLEEP                = 258,
	SCANCODE_WAKE                 = 259,
	SCANCODE_CHANNEL_INCREMENT    = 260,
	SCANCODE_CHANNEL_DECREMENT    = 261,
	SCANCODE_MEDIA_PLAY           = 262,
	SCANCODE_MEDIA_PAUSE          = 263,
	SCANCODE_MEDIA_RECORD         = 264,
	SCANCODE_MEDIA_FAST_FORWARD   = 265,
	SCANCODE_MEDIA_REWIND         = 266,
	SCANCODE_MEDIA_NEXT_TRACK     = 267,
	SCANCODE_MEDIA_PREVIOUS_TRACK = 268,
	SCANCODE_MEDIA_STOP           = 269,
	SCANCODE_MEDIA_EJECT          = 270,
	SCANCODE_MEDIA_PLAY_PAUSE     = 271,
	SCANCODE_MEDIA_SELECT         = 272,
	SCANCODE_AC_NEW               = 273,
	SCANCODE_AC_OPEN              = 274,
	SCANCODE_AC_CLOSE             = 275,
	SCANCODE_AC_EXIT              = 276,
	SCANCODE_AC_SAVE              = 277,
	SCANCODE_AC_PRINT             = 278,
	SCANCODE_AC_PROPERTIES        = 279,
	SCANCODE_AC_SEARCH            = 280,
	SCANCODE_AC_HOME              = 281,
	SCANCODE_AC_BACK              = 282,
	SCANCODE_AC_FORWARD           = 283,
	SCANCODE_AC_STOP              = 284,
	SCANCODE_AC_REFRESH           = 285,
	SCANCODE_AC_BOOKMARKS         = 286,
	SCANCODE_SOFTLEFT             = 287,
	SCANCODE_SOFTRIGHT            = 288,
	SCANCODE_CALL                 = 289,
	SCANCODE_ENDCALL              = 290,
	SCANCODE_RESERVED             = 400,
	SCANCODE_COUNT                = 512,
}
Keycode :: u32
Keymod :: u16
KeyboardID :: u32
TextInputType :: enum u32 {
	TEXTINPUT_TYPE_TEXT                    = 0,
	TEXTINPUT_TYPE_TEXT_NAME               = 1,
	TEXTINPUT_TYPE_TEXT_EMAIL              = 2,
	TEXTINPUT_TYPE_TEXT_USERNAME           = 3,
	TEXTINPUT_TYPE_TEXT_PASSWORD_HIDDEN    = 4,
	TEXTINPUT_TYPE_TEXT_PASSWORD_VISIBLE   = 5,
	TEXTINPUT_TYPE_NUMBER                  = 6,
	TEXTINPUT_TYPE_NUMBER_PASSWORD_HIDDEN  = 7,
	TEXTINPUT_TYPE_NUMBER_PASSWORD_VISIBLE = 8,
}
Capitalization :: enum u32 {
	CAPITALIZE_NONE      = 0,
	CAPITALIZE_SENTENCES = 1,
	CAPITALIZE_WORDS     = 2,
	CAPITALIZE_LETTERS   = 3,
}
MouseID :: u32
Cursor :: rawptr
SystemCursor :: enum u32 {
	SYSTEM_CURSOR_DEFAULT     = 0,
	SYSTEM_CURSOR_TEXT        = 1,
	SYSTEM_CURSOR_WAIT        = 2,
	SYSTEM_CURSOR_CROSSHAIR   = 3,
	SYSTEM_CURSOR_PROGRESS    = 4,
	SYSTEM_CURSOR_NWSE_RESIZE = 5,
	SYSTEM_CURSOR_NESW_RESIZE = 6,
	SYSTEM_CURSOR_EW_RESIZE   = 7,
	SYSTEM_CURSOR_NS_RESIZE   = 8,
	SYSTEM_CURSOR_MOVE        = 9,
	SYSTEM_CURSOR_NOT_ALLOWED = 10,
	SYSTEM_CURSOR_POINTER     = 11,
	SYSTEM_CURSOR_NW_RESIZE   = 12,
	SYSTEM_CURSOR_N_RESIZE    = 13,
	SYSTEM_CURSOR_NE_RESIZE   = 14,
	SYSTEM_CURSOR_E_RESIZE    = 15,
	SYSTEM_CURSOR_SE_RESIZE   = 16,
	SYSTEM_CURSOR_S_RESIZE    = 17,
	SYSTEM_CURSOR_SW_RESIZE   = 18,
	SYSTEM_CURSOR_W_RESIZE    = 19,
	SYSTEM_CURSOR_COUNT       = 20,
}
MouseWheelDirection :: enum u32 {
	MOUSEWHEEL_NORMAL  = 0,
	MOUSEWHEEL_FLIPPED = 1,
}
MouseButtonFlags :: u32
PenID :: u32
PenInputFlags :: u32
PenAxis :: enum u32 {
	PEN_AXIS_PRESSURE            = 0,
	PEN_AXIS_XTILT               = 1,
	PEN_AXIS_YTILT               = 2,
	PEN_AXIS_DISTANCE            = 3,
	PEN_AXIS_ROTATION            = 4,
	PEN_AXIS_SLIDER              = 5,
	PEN_AXIS_TANGENTIAL_PRESSURE = 6,
	PEN_AXIS_COUNT               = 7,
}
TouchID :: u64
FingerID :: u64
TouchDeviceType :: enum i32 {
	TOUCH_DEVICE_INVALID           = -1,
	TOUCH_DEVICE_DIRECT            = 0,
	TOUCH_DEVICE_INDIRECT_ABSOLUTE = 1,
	TOUCH_DEVICE_INDIRECT_RELATIVE = 2,
}
Finger :: struct {
	id:       FingerID,
	x:        f32,
	y:        f32,
	pressure: f32,
}
EventType :: enum u32 {
	EVENT_FIRST                         = 0,
	EVENT_QUIT                          = 256,
	EVENT_TERMINATING                   = 257,
	EVENT_LOW_MEMORY                    = 258,
	EVENT_WILL_ENTER_BACKGROUND         = 259,
	EVENT_DID_ENTER_BACKGROUND          = 260,
	EVENT_WILL_ENTER_FOREGROUND         = 261,
	EVENT_DID_ENTER_FOREGROUND          = 262,
	EVENT_LOCALE_CHANGED                = 263,
	EVENT_SYSTEM_THEME_CHANGED          = 264,
	EVENT_DISPLAY_ORIENTATION           = 337,
	EVENT_DISPLAY_ADDED                 = 338,
	EVENT_DISPLAY_REMOVED               = 339,
	EVENT_DISPLAY_MOVED                 = 340,
	EVENT_DISPLAY_DESKTOP_MODE_CHANGED  = 341,
	EVENT_DISPLAY_CURRENT_MODE_CHANGED  = 342,
	EVENT_DISPLAY_CONTENT_SCALE_CHANGED = 343,
	EVENT_DISPLAY_FIRST                 = 337,
	EVENT_DISPLAY_LAST                  = 343,
	EVENT_WINDOW_SHOWN                  = 514,
	EVENT_WINDOW_HIDDEN                 = 515,
	EVENT_WINDOW_EXPOSED                = 516,
	EVENT_WINDOW_MOVED                  = 517,
	EVENT_WINDOW_RESIZED                = 518,
	EVENT_WINDOW_PIXEL_SIZE_CHANGED     = 519,
	EVENT_WINDOW_METAL_VIEW_RESIZED     = 520,
	EVENT_WINDOW_MINIMIZED              = 521,
	EVENT_WINDOW_MAXIMIZED              = 522,
	EVENT_WINDOW_RESTORED               = 523,
	EVENT_WINDOW_MOUSE_ENTER            = 524,
	EVENT_WINDOW_MOUSE_LEAVE            = 525,
	EVENT_WINDOW_FOCUS_GAINED           = 526,
	EVENT_WINDOW_FOCUS_LOST             = 527,
	EVENT_WINDOW_CLOSE_REQUESTED        = 528,
	EVENT_WINDOW_HIT_TEST               = 529,
	EVENT_WINDOW_ICCPROF_CHANGED        = 530,
	EVENT_WINDOW_DISPLAY_CHANGED        = 531,
	EVENT_WINDOW_DISPLAY_SCALE_CHANGED  = 532,
	EVENT_WINDOW_SAFE_AREA_CHANGED      = 533,
	EVENT_WINDOW_OCCLUDED               = 534,
	EVENT_WINDOW_ENTER_FULLSCREEN       = 535,
	EVENT_WINDOW_LEAVE_FULLSCREEN       = 536,
	EVENT_WINDOW_DESTROYED              = 537,
	EVENT_WINDOW_HDR_STATE_CHANGED      = 538,
	EVENT_WINDOW_FIRST                  = 514,
	EVENT_WINDOW_LAST                   = 538,
	EVENT_KEY_DOWN                      = 768,
	EVENT_KEY_UP                        = 769,
	EVENT_TEXT_EDITING                  = 770,
	EVENT_TEXT_INPUT                    = 771,
	EVENT_KEYMAP_CHANGED                = 772,
	EVENT_KEYBOARD_ADDED                = 773,
	EVENT_KEYBOARD_REMOVED              = 774,
	EVENT_TEXT_EDITING_CANDIDATES       = 775,
	EVENT_MOUSE_MOTION                  = 1024,
	EVENT_MOUSE_BUTTON_DOWN             = 1025,
	EVENT_MOUSE_BUTTON_UP               = 1026,
	EVENT_MOUSE_WHEEL                   = 1027,
	EVENT_MOUSE_ADDED                   = 1028,
	EVENT_MOUSE_REMOVED                 = 1029,
	EVENT_JOYSTICK_AXIS_MOTION          = 1536,
	EVENT_JOYSTICK_BALL_MOTION          = 1537,
	EVENT_JOYSTICK_HAT_MOTION           = 1538,
	EVENT_JOYSTICK_BUTTON_DOWN          = 1539,
	EVENT_JOYSTICK_BUTTON_UP            = 1540,
	EVENT_JOYSTICK_ADDED                = 1541,
	EVENT_JOYSTICK_REMOVED              = 1542,
	EVENT_JOYSTICK_BATTERY_UPDATED      = 1543,
	EVENT_JOYSTICK_UPDATE_COMPLETE      = 1544,
	EVENT_GAMEPAD_AXIS_MOTION           = 1616,
	EVENT_GAMEPAD_BUTTON_DOWN           = 1617,
	EVENT_GAMEPAD_BUTTON_UP             = 1618,
	EVENT_GAMEPAD_ADDED                 = 1619,
	EVENT_GAMEPAD_REMOVED               = 1620,
	EVENT_GAMEPAD_REMAPPED              = 1621,
	EVENT_GAMEPAD_TOUCHPAD_DOWN         = 1622,
	EVENT_GAMEPAD_TOUCHPAD_MOTION       = 1623,
	EVENT_GAMEPAD_TOUCHPAD_UP           = 1624,
	EVENT_GAMEPAD_SENSOR_UPDATE         = 1625,
	EVENT_GAMEPAD_UPDATE_COMPLETE       = 1626,
	EVENT_GAMEPAD_STEAM_HANDLE_UPDATED  = 1627,
	EVENT_FINGER_DOWN                   = 1792,
	EVENT_FINGER_UP                     = 1793,
	EVENT_FINGER_MOTION                 = 1794,
	EVENT_CLIPBOARD_UPDATE              = 2304,
	EVENT_DROP_FILE                     = 4096,
	EVENT_DROP_TEXT                     = 4097,
	EVENT_DROP_BEGIN                    = 4098,
	EVENT_DROP_COMPLETE                 = 4099,
	EVENT_DROP_POSITION                 = 4100,
	EVENT_AUDIO_DEVICE_ADDED            = 4352,
	EVENT_AUDIO_DEVICE_REMOVED          = 4353,
	EVENT_AUDIO_DEVICE_FORMAT_CHANGED   = 4354,
	EVENT_SENSOR_UPDATE                 = 4608,
	EVENT_PEN_PROXIMITY_IN              = 4864,
	EVENT_PEN_PROXIMITY_OUT             = 4865,
	EVENT_PEN_DOWN                      = 4866,
	EVENT_PEN_UP                        = 4867,
	EVENT_PEN_BUTTON_DOWN               = 4868,
	EVENT_PEN_BUTTON_UP                 = 4869,
	EVENT_PEN_MOTION                    = 4870,
	EVENT_PEN_AXIS                      = 4871,
	EVENT_CAMERA_DEVICE_ADDED           = 5120,
	EVENT_CAMERA_DEVICE_REMOVED         = 5121,
	EVENT_CAMERA_DEVICE_APPROVED        = 5122,
	EVENT_CAMERA_DEVICE_DENIED          = 5123,
	EVENT_RENDER_TARGETS_RESET          = 8192,
	EVENT_RENDER_DEVICE_RESET           = 8193,
	EVENT_RENDER_DEVICE_LOST            = 8194,
	EVENT_PRIVATE0                      = 16384,
	EVENT_PRIVATE1                      = 16385,
	EVENT_PRIVATE2                      = 16386,
	EVENT_PRIVATE3                      = 16387,
	EVENT_POLL_SENTINEL                 = 32512,
	EVENT_USER                          = 32768,
	EVENT_LAST                          = 65535,
	EVENT_ENUM_PADDING                  = 2147483647,
}
CommonEvent :: struct {
	type:      u32,
	reserved:  u32,
	timestamp: u64,
}
DisplayEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	displayID: DisplayID,
	data1:     i32,
	data2:     i32,
}
WindowEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	data1:     i32,
	data2:     i32,
}
KeyboardDeviceEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     KeyboardID,
}
KeyboardEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     KeyboardID,
	scancode:  Scancode,
	key:       Keycode,
	mod:       Keymod,
	raw:       u16,
	down:      b8,
	repeat:    b8,
}
TextEditingEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	text:      cstring,
	start:     i32,
	length:    i32,
}
TextEditingCandidatesEvent :: struct {
	type:               EventType,
	reserved:           u32,
	timestamp:          u64,
	windowID:           WindowID,
	candidates:         [^]cstring,
	num_candidates:     i32,
	selected_candidate: i32,
	horizontal:         b8,
	padding1:           u8,
	padding2:           u8,
	padding3:           u8,
}
TextInputEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	text:      cstring,
}
MouseDeviceEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     MouseID,
}
MouseMotionEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     MouseID,
	state:     MouseButtonFlags,
	x:         f32,
	y:         f32,
	xrel:      f32,
	yrel:      f32,
}
MouseButtonEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     MouseID,
	button:    u8,
	down:      b8,
	clicks:    u8,
	padding:   u8,
	x:         f32,
	y:         f32,
}
MouseWheelEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     MouseID,
	x:         f32,
	y:         f32,
	direction: MouseWheelDirection,
	mouse_x:   f32,
	mouse_y:   f32,
}
JoyAxisEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	axis:      u8,
	padding1:  u8,
	padding2:  u8,
	padding3:  u8,
	value:     i16,
	padding4:  u16,
}
JoyBallEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	ball:      u8,
	padding1:  u8,
	padding2:  u8,
	padding3:  u8,
	xrel:      i16,
	yrel:      i16,
}
JoyHatEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	hat:       u8,
	value:     u8,
	padding1:  u8,
	padding2:  u8,
}
JoyButtonEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	button:    u8,
	down:      b8,
	padding1:  u8,
	padding2:  u8,
}
JoyDeviceEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
}
JoyBatteryEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	state:     PowerState,
	percent:   i32,
}
GamepadAxisEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	axis:      u8,
	padding1:  u8,
	padding2:  u8,
	padding3:  u8,
	value:     i16,
	padding4:  u16,
}
GamepadButtonEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	button:    u8,
	down:      b8,
	padding1:  u8,
	padding2:  u8,
}
GamepadDeviceEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
}
GamepadTouchpadEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     JoystickID,
	touchpad:  i32,
	finger:    i32,
	x:         f32,
	y:         f32,
	pressure:  f32,
}
GamepadSensorEvent :: struct {
	type:             EventType,
	reserved:         u32,
	timestamp:        u64,
	which:            JoystickID,
	sensor:           i32,
	data:             [3]f32,
	sensor_timestamp: u64,
}
AudioDeviceEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     AudioDeviceID,
	recording: b8,
	padding1:  u8,
	padding2:  u8,
	padding3:  u8,
}
CameraDeviceEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	which:     CameraID,
}
TouchFingerEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	touchID:   TouchID,
	fingerID:  FingerID,
	x:         f32,
	y:         f32,
	dx:        f32,
	dy:        f32,
	pressure:  f32,
	windowID:  WindowID,
}
PenProximityEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     PenID,
}
PenMotionEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     PenID,
	pen_state: PenInputFlags,
	x:         f32,
	y:         f32,
}
PenTouchEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     PenID,
	pen_state: PenInputFlags,
	x:         f32,
	y:         f32,
	eraser:    b8,
	down:      b8,
}
PenButtonEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     PenID,
	pen_state: PenInputFlags,
	x:         f32,
	y:         f32,
	button:    u8,
	down:      b8,
}
PenAxisEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	which:     PenID,
	pen_state: PenInputFlags,
	x:         f32,
	y:         f32,
	axis:      PenAxis,
	value:     f32,
}
DropEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	x:         f32,
	y:         f32,
	source:    cstring,
	data:      cstring,
}
ClipboardEvent :: struct {
	type:         EventType,
	reserved:     u32,
	timestamp:    u64,
	owner:        b8,
	n_mime_types: i32,
	mime_types:   [^]cstring,
}
SensorEvent :: struct {
	type:             EventType,
	reserved:         u32,
	timestamp:        u64,
	which:            SensorID,
	data:             [6]f32,
	sensor_timestamp: u64,
}
QuitEvent :: struct {
	type:      EventType,
	reserved:  u32,
	timestamp: u64,
}
UserEvent :: struct {
	type:      u32,
	reserved:  u32,
	timestamp: u64,
	windowID:  WindowID,
	code:      i32,
	data1:     rawptr,
	data2:     rawptr,
}
Event :: struct #raw_union {
	type:            u32,
	common:          CommonEvent,
	display:         DisplayEvent,
	window:          WindowEvent,
	kdevice:         KeyboardDeviceEvent,
	key:             KeyboardEvent,
	edit:            TextEditingEvent,
	edit_candidates: TextEditingCandidatesEvent,
	text:            TextInputEvent,
	mdevice:         MouseDeviceEvent,
	motion:          MouseMotionEvent,
	button:          MouseButtonEvent,
	wheel:           MouseWheelEvent,
	jdevice:         JoyDeviceEvent,
	jaxis:           JoyAxisEvent,
	jball:           JoyBallEvent,
	jhat:            JoyHatEvent,
	jbutton:         JoyButtonEvent,
	jbattery:        JoyBatteryEvent,
	gdevice:         GamepadDeviceEvent,
	gaxis:           GamepadAxisEvent,
	gbutton:         GamepadButtonEvent,
	gtouchpad:       GamepadTouchpadEvent,
	gsensor:         GamepadSensorEvent,
	adevice:         AudioDeviceEvent,
	cdevice:         CameraDeviceEvent,
	sensor:          SensorEvent,
	quit:            QuitEvent,
	user:            UserEvent,
	tfinger:         TouchFingerEvent,
	pproximity:      PenProximityEvent,
	ptouch:          PenTouchEvent,
	pmotion:         PenMotionEvent,
	pbutton:         PenButtonEvent,
	paxis:           PenAxisEvent,
	drop:            DropEvent,
	clipboard:       ClipboardEvent,
	padding:         [128]u8,
}
EventAction :: enum u32 {
	ADDEVENT  = 0,
	PEEKEVENT = 1,
	GETEVENT  = 2,
}
EventFilter :: #type proc "c" (userdata: rawptr, event: ^Event) -> b8
Folder :: enum u32 {
	FOLDER_HOME        = 0,
	FOLDER_DESKTOP     = 1,
	FOLDER_DOCUMENTS   = 2,
	FOLDER_DOWNLOADS   = 3,
	FOLDER_MUSIC       = 4,
	FOLDER_PICTURES    = 5,
	FOLDER_PUBLICSHARE = 6,
	FOLDER_SAVEDGAMES  = 7,
	FOLDER_SCREENSHOTS = 8,
	FOLDER_TEMPLATES   = 9,
	FOLDER_VIDEOS      = 10,
	FOLDER_COUNT       = 11,
}
PathType :: enum u32 {
	PATHTYPE_NONE      = 0,
	PATHTYPE_FILE      = 1,
	PATHTYPE_DIRECTORY = 2,
	PATHTYPE_OTHER     = 3,
}
PathInfo :: struct {
	type:        PathType,
	size:        u64,
	create_time: i64,
	modify_time: i64,
	access_time: i64,
}
GlobFlags :: u32
EnumerationResult :: enum u32 {
	ENUM_CONTINUE = 0,
	ENUM_SUCCESS  = 1,
	ENUM_FAILURE  = 2,
}
EnumerateDirectoryCallback :: #type proc "c" (
	userdata: rawptr,
	dirname: cstring,
	fname: cstring,
) -> EnumerationResult
GPUDevice :: rawptr
GPUBuffer :: rawptr
GPUTransferBuffer :: rawptr
GPUTexture :: rawptr
GPUSampler :: rawptr
GPUShader :: rawptr
GPUComputePipeline :: rawptr
GPUGraphicsPipeline :: rawptr
GPUCommandBuffer :: rawptr
GPURenderPass :: rawptr
GPUComputePass :: rawptr
GPUCopyPass :: rawptr
GPUFence :: rawptr
GPUPrimitiveType :: enum u32 {
	GPU_PRIMITIVETYPE_TRIANGLELIST  = 0,
	GPU_PRIMITIVETYPE_TRIANGLESTRIP = 1,
	GPU_PRIMITIVETYPE_LINELIST      = 2,
	GPU_PRIMITIVETYPE_LINESTRIP     = 3,
	GPU_PRIMITIVETYPE_POINTLIST     = 4,
}
GPULoadOp :: enum u32 {
	GPU_LOADOP_LOAD      = 0,
	GPU_LOADOP_CLEAR     = 1,
	GPU_LOADOP_DONT_CARE = 2,
}
GPUStoreOp :: enum u32 {
	GPU_STOREOP_STORE             = 0,
	GPU_STOREOP_DONT_CARE         = 1,
	GPU_STOREOP_RESOLVE           = 2,
	GPU_STOREOP_RESOLVE_AND_STORE = 3,
}
GPUIndexElementSize :: enum u32 {
	GPU_INDEXELEMENTSIZE_16BIT = 0,
	GPU_INDEXELEMENTSIZE_32BIT = 1,
}
GPUTextureFormat :: enum u32 {
	GPU_TEXTUREFORMAT_INVALID               = 0,
	GPU_TEXTUREFORMAT_A8_UNORM              = 1,
	GPU_TEXTUREFORMAT_R8_UNORM              = 2,
	GPU_TEXTUREFORMAT_R8G8_UNORM            = 3,
	GPU_TEXTUREFORMAT_R8G8B8A8_UNORM        = 4,
	GPU_TEXTUREFORMAT_R16_UNORM             = 5,
	GPU_TEXTUREFORMAT_R16G16_UNORM          = 6,
	GPU_TEXTUREFORMAT_R16G16B16A16_UNORM    = 7,
	GPU_TEXTUREFORMAT_R10G10B10A2_UNORM     = 8,
	GPU_TEXTUREFORMAT_B5G6R5_UNORM          = 9,
	GPU_TEXTUREFORMAT_B5G5R5A1_UNORM        = 10,
	GPU_TEXTUREFORMAT_B4G4R4A4_UNORM        = 11,
	GPU_TEXTUREFORMAT_B8G8R8A8_UNORM        = 12,
	GPU_TEXTUREFORMAT_BC1_RGBA_UNORM        = 13,
	GPU_TEXTUREFORMAT_BC2_RGBA_UNORM        = 14,
	GPU_TEXTUREFORMAT_BC3_RGBA_UNORM        = 15,
	GPU_TEXTUREFORMAT_BC4_R_UNORM           = 16,
	GPU_TEXTUREFORMAT_BC5_RG_UNORM          = 17,
	GPU_TEXTUREFORMAT_BC7_RGBA_UNORM        = 18,
	GPU_TEXTUREFORMAT_BC6H_RGB_FLOAT        = 19,
	GPU_TEXTUREFORMAT_BC6H_RGB_UFLOAT       = 20,
	GPU_TEXTUREFORMAT_R8_SNORM              = 21,
	GPU_TEXTUREFORMAT_R8G8_SNORM            = 22,
	GPU_TEXTUREFORMAT_R8G8B8A8_SNORM        = 23,
	GPU_TEXTUREFORMAT_R16_SNORM             = 24,
	GPU_TEXTUREFORMAT_R16G16_SNORM          = 25,
	GPU_TEXTUREFORMAT_R16G16B16A16_SNORM    = 26,
	GPU_TEXTUREFORMAT_R16_FLOAT             = 27,
	GPU_TEXTUREFORMAT_R16G16_FLOAT          = 28,
	GPU_TEXTUREFORMAT_R16G16B16A16_FLOAT    = 29,
	GPU_TEXTUREFORMAT_R32_FLOAT             = 30,
	GPU_TEXTUREFORMAT_R32G32_FLOAT          = 31,
	GPU_TEXTUREFORMAT_R32G32B32A32_FLOAT    = 32,
	GPU_TEXTUREFORMAT_R11G11B10_UFLOAT      = 33,
	GPU_TEXTUREFORMAT_R8_UINT               = 34,
	GPU_TEXTUREFORMAT_R8G8_UINT             = 35,
	GPU_TEXTUREFORMAT_R8G8B8A8_UINT         = 36,
	GPU_TEXTUREFORMAT_R16_UINT              = 37,
	GPU_TEXTUREFORMAT_R16G16_UINT           = 38,
	GPU_TEXTUREFORMAT_R16G16B16A16_UINT     = 39,
	GPU_TEXTUREFORMAT_R32_UINT              = 40,
	GPU_TEXTUREFORMAT_R32G32_UINT           = 41,
	GPU_TEXTUREFORMAT_R32G32B32A32_UINT     = 42,
	GPU_TEXTUREFORMAT_R8_INT                = 43,
	GPU_TEXTUREFORMAT_R8G8_INT              = 44,
	GPU_TEXTUREFORMAT_R8G8B8A8_INT          = 45,
	GPU_TEXTUREFORMAT_R16_INT               = 46,
	GPU_TEXTUREFORMAT_R16G16_INT            = 47,
	GPU_TEXTUREFORMAT_R16G16B16A16_INT      = 48,
	GPU_TEXTUREFORMAT_R32_INT               = 49,
	GPU_TEXTUREFORMAT_R32G32_INT            = 50,
	GPU_TEXTUREFORMAT_R32G32B32A32_INT      = 51,
	GPU_TEXTUREFORMAT_R8G8B8A8_UNORM_SRGB   = 52,
	GPU_TEXTUREFORMAT_B8G8R8A8_UNORM_SRGB   = 53,
	GPU_TEXTUREFORMAT_BC1_RGBA_UNORM_SRGB   = 54,
	GPU_TEXTUREFORMAT_BC2_RGBA_UNORM_SRGB   = 55,
	GPU_TEXTUREFORMAT_BC3_RGBA_UNORM_SRGB   = 56,
	GPU_TEXTUREFORMAT_BC7_RGBA_UNORM_SRGB   = 57,
	GPU_TEXTUREFORMAT_D16_UNORM             = 58,
	GPU_TEXTUREFORMAT_D24_UNORM             = 59,
	GPU_TEXTUREFORMAT_D32_FLOAT             = 60,
	GPU_TEXTUREFORMAT_D24_UNORM_S8_UINT     = 61,
	GPU_TEXTUREFORMAT_D32_FLOAT_S8_UINT     = 62,
	GPU_TEXTUREFORMAT_ASTC_4x4_UNORM        = 63,
	GPU_TEXTUREFORMAT_ASTC_5x4_UNORM        = 64,
	GPU_TEXTUREFORMAT_ASTC_5x5_UNORM        = 65,
	GPU_TEXTUREFORMAT_ASTC_6x5_UNORM        = 66,
	GPU_TEXTUREFORMAT_ASTC_6x6_UNORM        = 67,
	GPU_TEXTUREFORMAT_ASTC_8x5_UNORM        = 68,
	GPU_TEXTUREFORMAT_ASTC_8x6_UNORM        = 69,
	GPU_TEXTUREFORMAT_ASTC_8x8_UNORM        = 70,
	GPU_TEXTUREFORMAT_ASTC_10x5_UNORM       = 71,
	GPU_TEXTUREFORMAT_ASTC_10x6_UNORM       = 72,
	GPU_TEXTUREFORMAT_ASTC_10x8_UNORM       = 73,
	GPU_TEXTUREFORMAT_ASTC_10x10_UNORM      = 74,
	GPU_TEXTUREFORMAT_ASTC_12x10_UNORM      = 75,
	GPU_TEXTUREFORMAT_ASTC_12x12_UNORM      = 76,
	GPU_TEXTUREFORMAT_ASTC_4x4_UNORM_SRGB   = 77,
	GPU_TEXTUREFORMAT_ASTC_5x4_UNORM_SRGB   = 78,
	GPU_TEXTUREFORMAT_ASTC_5x5_UNORM_SRGB   = 79,
	GPU_TEXTUREFORMAT_ASTC_6x5_UNORM_SRGB   = 80,
	GPU_TEXTUREFORMAT_ASTC_6x6_UNORM_SRGB   = 81,
	GPU_TEXTUREFORMAT_ASTC_8x5_UNORM_SRGB   = 82,
	GPU_TEXTUREFORMAT_ASTC_8x6_UNORM_SRGB   = 83,
	GPU_TEXTUREFORMAT_ASTC_8x8_UNORM_SRGB   = 84,
	GPU_TEXTUREFORMAT_ASTC_10x5_UNORM_SRGB  = 85,
	GPU_TEXTUREFORMAT_ASTC_10x6_UNORM_SRGB  = 86,
	GPU_TEXTUREFORMAT_ASTC_10x8_UNORM_SRGB  = 87,
	GPU_TEXTUREFORMAT_ASTC_10x10_UNORM_SRGB = 88,
	GPU_TEXTUREFORMAT_ASTC_12x10_UNORM_SRGB = 89,
	GPU_TEXTUREFORMAT_ASTC_12x12_UNORM_SRGB = 90,
	GPU_TEXTUREFORMAT_ASTC_4x4_FLOAT        = 91,
	GPU_TEXTUREFORMAT_ASTC_5x4_FLOAT        = 92,
	GPU_TEXTUREFORMAT_ASTC_5x5_FLOAT        = 93,
	GPU_TEXTUREFORMAT_ASTC_6x5_FLOAT        = 94,
	GPU_TEXTUREFORMAT_ASTC_6x6_FLOAT        = 95,
	GPU_TEXTUREFORMAT_ASTC_8x5_FLOAT        = 96,
	GPU_TEXTUREFORMAT_ASTC_8x6_FLOAT        = 97,
	GPU_TEXTUREFORMAT_ASTC_8x8_FLOAT        = 98,
	GPU_TEXTUREFORMAT_ASTC_10x5_FLOAT       = 99,
	GPU_TEXTUREFORMAT_ASTC_10x6_FLOAT       = 100,
	GPU_TEXTUREFORMAT_ASTC_10x8_FLOAT       = 101,
	GPU_TEXTUREFORMAT_ASTC_10x10_FLOAT      = 102,
	GPU_TEXTUREFORMAT_ASTC_12x10_FLOAT      = 103,
	GPU_TEXTUREFORMAT_ASTC_12x12_FLOAT      = 104,
}
GPUTextureUsageFlags :: u32
GPUTextureType :: enum u32 {
	GPU_TEXTURETYPE_2D         = 0,
	GPU_TEXTURETYPE_2D_ARRAY   = 1,
	GPU_TEXTURETYPE_3D         = 2,
	GPU_TEXTURETYPE_CUBE       = 3,
	GPU_TEXTURETYPE_CUBE_ARRAY = 4,
}
GPUSampleCount :: enum u32 {
	GPU_SAMPLECOUNT_1 = 0,
	GPU_SAMPLECOUNT_2 = 1,
	GPU_SAMPLECOUNT_4 = 2,
	GPU_SAMPLECOUNT_8 = 3,
}
GPUCubeMapFace :: enum u32 {
	GPU_CUBEMAPFACE_POSITIVEX = 0,
	GPU_CUBEMAPFACE_NEGATIVEX = 1,
	GPU_CUBEMAPFACE_POSITIVEY = 2,
	GPU_CUBEMAPFACE_NEGATIVEY = 3,
	GPU_CUBEMAPFACE_POSITIVEZ = 4,
	GPU_CUBEMAPFACE_NEGATIVEZ = 5,
}
GPUBufferUsageFlags :: u32
GPUTransferBufferUsage :: enum u32 {
	GPU_TRANSFERBUFFERUSAGE_UPLOAD   = 0,
	GPU_TRANSFERBUFFERUSAGE_DOWNLOAD = 1,
}
GPUShaderStage :: enum u32 {
	GPU_SHADERSTAGE_VERTEX   = 0,
	GPU_SHADERSTAGE_FRAGMENT = 1,
}
GPUShaderFormat :: u32
GPUVertexElementFormat :: enum u32 {
	GPU_VERTEXELEMENTFORMAT_INVALID      = 0,
	GPU_VERTEXELEMENTFORMAT_INT          = 1,
	GPU_VERTEXELEMENTFORMAT_INT2         = 2,
	GPU_VERTEXELEMENTFORMAT_INT3         = 3,
	GPU_VERTEXELEMENTFORMAT_INT4         = 4,
	GPU_VERTEXELEMENTFORMAT_UINT         = 5,
	GPU_VERTEXELEMENTFORMAT_UINT2        = 6,
	GPU_VERTEXELEMENTFORMAT_UINT3        = 7,
	GPU_VERTEXELEMENTFORMAT_UINT4        = 8,
	GPU_VERTEXELEMENTFORMAT_FLOAT        = 9,
	GPU_VERTEXELEMENTFORMAT_FLOAT2       = 10,
	GPU_VERTEXELEMENTFORMAT_FLOAT3       = 11,
	GPU_VERTEXELEMENTFORMAT_FLOAT4       = 12,
	GPU_VERTEXELEMENTFORMAT_BYTE2        = 13,
	GPU_VERTEXELEMENTFORMAT_BYTE4        = 14,
	GPU_VERTEXELEMENTFORMAT_UBYTE2       = 15,
	GPU_VERTEXELEMENTFORMAT_UBYTE4       = 16,
	GPU_VERTEXELEMENTFORMAT_BYTE2_NORM   = 17,
	GPU_VERTEXELEMENTFORMAT_BYTE4_NORM   = 18,
	GPU_VERTEXELEMENTFORMAT_UBYTE2_NORM  = 19,
	GPU_VERTEXELEMENTFORMAT_UBYTE4_NORM  = 20,
	GPU_VERTEXELEMENTFORMAT_SHORT2       = 21,
	GPU_VERTEXELEMENTFORMAT_SHORT4       = 22,
	GPU_VERTEXELEMENTFORMAT_USHORT2      = 23,
	GPU_VERTEXELEMENTFORMAT_USHORT4      = 24,
	GPU_VERTEXELEMENTFORMAT_SHORT2_NORM  = 25,
	GPU_VERTEXELEMENTFORMAT_SHORT4_NORM  = 26,
	GPU_VERTEXELEMENTFORMAT_USHORT2_NORM = 27,
	GPU_VERTEXELEMENTFORMAT_USHORT4_NORM = 28,
	GPU_VERTEXELEMENTFORMAT_HALF2        = 29,
	GPU_VERTEXELEMENTFORMAT_HALF4        = 30,
}
GPUVertexInputRate :: enum u32 {
	GPU_VERTEXINPUTRATE_VERTEX   = 0,
	GPU_VERTEXINPUTRATE_INSTANCE = 1,
}
GPUFillMode :: enum u32 {
	GPU_FILLMODE_FILL = 0,
	GPU_FILLMODE_LINE = 1,
}
GPUCullMode :: enum u32 {
	GPU_CULLMODE_NONE  = 0,
	GPU_CULLMODE_FRONT = 1,
	GPU_CULLMODE_BACK  = 2,
}
GPUFrontFace :: enum u32 {
	GPU_FRONTFACE_COUNTER_CLOCKWISE = 0,
	GPU_FRONTFACE_CLOCKWISE         = 1,
}
GPUCompareOp :: enum u32 {
	GPU_COMPAREOP_INVALID          = 0,
	GPU_COMPAREOP_NEVER            = 1,
	GPU_COMPAREOP_LESS             = 2,
	GPU_COMPAREOP_EQUAL            = 3,
	GPU_COMPAREOP_LESS_OR_EQUAL    = 4,
	GPU_COMPAREOP_GREATER          = 5,
	GPU_COMPAREOP_NOT_EQUAL        = 6,
	GPU_COMPAREOP_GREATER_OR_EQUAL = 7,
	GPU_COMPAREOP_ALWAYS           = 8,
}
GPUStencilOp :: enum u32 {
	GPU_STENCILOP_INVALID             = 0,
	GPU_STENCILOP_KEEP                = 1,
	GPU_STENCILOP_ZERO                = 2,
	GPU_STENCILOP_REPLACE             = 3,
	GPU_STENCILOP_INCREMENT_AND_CLAMP = 4,
	GPU_STENCILOP_DECREMENT_AND_CLAMP = 5,
	GPU_STENCILOP_INVERT              = 6,
	GPU_STENCILOP_INCREMENT_AND_WRAP  = 7,
	GPU_STENCILOP_DECREMENT_AND_WRAP  = 8,
}
GPUBlendOp :: enum u32 {
	GPU_BLENDOP_INVALID          = 0,
	GPU_BLENDOP_ADD              = 1,
	GPU_BLENDOP_SUBTRACT         = 2,
	GPU_BLENDOP_REVERSE_SUBTRACT = 3,
	GPU_BLENDOP_MIN              = 4,
	GPU_BLENDOP_MAX              = 5,
}
GPUBlendFactor :: enum u32 {
	GPU_BLENDFACTOR_INVALID                  = 0,
	GPU_BLENDFACTOR_ZERO                     = 1,
	GPU_BLENDFACTOR_ONE                      = 2,
	GPU_BLENDFACTOR_SRC_COLOR                = 3,
	GPU_BLENDFACTOR_ONE_MINUS_SRC_COLOR      = 4,
	GPU_BLENDFACTOR_DST_COLOR                = 5,
	GPU_BLENDFACTOR_ONE_MINUS_DST_COLOR      = 6,
	GPU_BLENDFACTOR_SRC_ALPHA                = 7,
	GPU_BLENDFACTOR_ONE_MINUS_SRC_ALPHA      = 8,
	GPU_BLENDFACTOR_DST_ALPHA                = 9,
	GPU_BLENDFACTOR_ONE_MINUS_DST_ALPHA      = 10,
	GPU_BLENDFACTOR_CONSTANT_COLOR           = 11,
	GPU_BLENDFACTOR_ONE_MINUS_CONSTANT_COLOR = 12,
	GPU_BLENDFACTOR_SRC_ALPHA_SATURATE       = 13,
}
GPUColorComponentFlags :: u8
GPUFilter :: enum u32 {
	GPU_FILTER_NEAREST = 0,
	GPU_FILTER_LINEAR  = 1,
}
GPUSamplerMipmapMode :: enum u32 {
	GPU_SAMPLERMIPMAPMODE_NEAREST = 0,
	GPU_SAMPLERMIPMAPMODE_LINEAR  = 1,
}
GPUSamplerAddressMode :: enum u32 {
	GPU_SAMPLERADDRESSMODE_REPEAT          = 0,
	GPU_SAMPLERADDRESSMODE_MIRRORED_REPEAT = 1,
	GPU_SAMPLERADDRESSMODE_CLAMP_TO_EDGE   = 2,
}
GPUPresentMode :: enum u32 {
	GPU_PRESENTMODE_VSYNC     = 0,
	GPU_PRESENTMODE_IMMEDIATE = 1,
	GPU_PRESENTMODE_MAILBOX   = 2,
}
GPUSwapchainComposition :: enum u32 {
	GPU_SWAPCHAINCOMPOSITION_SDR                 = 0,
	GPU_SWAPCHAINCOMPOSITION_SDR_LINEAR          = 1,
	GPU_SWAPCHAINCOMPOSITION_HDR_EXTENDED_LINEAR = 2,
	GPU_SWAPCHAINCOMPOSITION_HDR10_ST2048        = 3,
}
GPUViewport :: struct {
	x:         f32,
	y:         f32,
	w:         f32,
	h:         f32,
	min_depth: f32,
	max_depth: f32,
}
GPUTextureTransferInfo :: struct {
	transfer_buffer: GPUTransferBuffer,
	offset:          u32,
	pixels_per_row:  u32,
	rows_per_layer:  u32,
}
GPUTransferBufferLocation :: struct {
	transfer_buffer: GPUTransferBuffer,
	offset:          u32,
}
GPUTextureLocation :: struct {
	texture:   GPUTexture,
	mip_level: u32,
	layer:     u32,
	x:         u32,
	y:         u32,
	z:         u32,
}
GPUTextureRegion :: struct {
	texture:   GPUTexture,
	mip_level: u32,
	layer:     u32,
	x:         u32,
	y:         u32,
	z:         u32,
	w:         u32,
	h:         u32,
	d:         u32,
}
GPUBlitRegion :: struct {
	texture:              GPUTexture,
	mip_level:            u32,
	layer_or_depth_plane: u32,
	x:                    u32,
	y:                    u32,
	w:                    u32,
	h:                    u32,
}
GPUBufferLocation :: struct {
	buffer: GPUBuffer,
	offset: u32,
}
GPUBufferRegion :: struct {
	buffer: GPUBuffer,
	offset: u32,
	size:   u32,
}
GPUIndirectDrawCommand :: struct {
	num_vertices:   u32,
	num_instances:  u32,
	first_vertex:   u32,
	first_instance: u32,
}
GPUIndexedIndirectDrawCommand :: struct {
	num_indices:    u32,
	num_instances:  u32,
	first_index:    u32,
	vertex_offset:  i32,
	first_instance: u32,
}
GPUIndirectDispatchCommand :: struct {
	groupcount_x: u32,
	groupcount_y: u32,
	groupcount_z: u32,
}
GPUSamplerCreateInfo :: struct {
	min_filter:        GPUFilter,
	mag_filter:        GPUFilter,
	mipmap_mode:       GPUSamplerMipmapMode,
	address_mode_u:    GPUSamplerAddressMode,
	address_mode_v:    GPUSamplerAddressMode,
	address_mode_w:    GPUSamplerAddressMode,
	mip_lod_bias:      f32,
	max_anisotropy:    f32,
	compare_op:        GPUCompareOp,
	min_lod:           f32,
	max_lod:           f32,
	enable_anisotropy: b8,
	enable_compare:    b8,
	padding1:          u8,
	padding2:          u8,
	props:             PropertiesID,
}
GPUVertexBufferDescription :: struct {
	slot:               u32,
	pitch:              u32,
	input_rate:         GPUVertexInputRate,
	instance_step_rate: u32,
}
GPUVertexAttribute :: struct {
	location:    u32,
	buffer_slot: u32,
	format:      GPUVertexElementFormat,
	offset:      u32,
}
GPUVertexInputState :: struct {
	vertex_buffer_descriptions: [^]GPUVertexBufferDescription,
	num_vertex_buffers:         u32,
	vertex_attributes:          [^]GPUVertexAttribute,
	num_vertex_attributes:      u32,
}
GPUStencilOpState :: struct {
	fail_op:       GPUStencilOp,
	pass_op:       GPUStencilOp,
	depth_fail_op: GPUStencilOp,
	compare_op:    GPUCompareOp,
}
GPUColorTargetBlendState :: struct {
	src_color_blendfactor:   GPUBlendFactor,
	dst_color_blendfactor:   GPUBlendFactor,
	color_blend_op:          GPUBlendOp,
	src_alpha_blendfactor:   GPUBlendFactor,
	dst_alpha_blendfactor:   GPUBlendFactor,
	alpha_blend_op:          GPUBlendOp,
	color_write_mask:        GPUColorComponentFlags,
	enable_blend:            b8,
	enable_color_write_mask: b8,
	padding1:                u8,
	padding2:                u8,
}
GPUShaderCreateInfo :: struct {
	code_size:            u64,
	code:                 ^u8,
	entrypoint:           cstring,
	format:               GPUShaderFormat,
	stage:                GPUShaderStage,
	num_samplers:         u32,
	num_storage_textures: u32,
	num_storage_buffers:  u32,
	num_uniform_buffers:  u32,
	props:                PropertiesID,
}
GPUTextureCreateInfo :: struct {
	type:                 GPUTextureType,
	format:               GPUTextureFormat,
	usage:                GPUTextureUsageFlags,
	width:                u32,
	height:               u32,
	layer_count_or_depth: u32,
	num_levels:           u32,
	sample_count:         GPUSampleCount,
	props:                PropertiesID,
}
GPUBufferCreateInfo :: struct {
	usage: GPUBufferUsageFlags,
	size:  u32,
	props: PropertiesID,
}
GPUTransferBufferCreateInfo :: struct {
	usage: GPUTransferBufferUsage,
	size:  u32,
	props: PropertiesID,
}
GPURasterizerState :: struct {
	fill_mode:                  GPUFillMode,
	cull_mode:                  GPUCullMode,
	front_face:                 GPUFrontFace,
	depth_bias_constant_factor: f32,
	depth_bias_clamp:           f32,
	depth_bias_slope_factor:    f32,
	enable_depth_bias:          b8,
	enable_depth_clip:          b8,
	padding1:                   u8,
	padding2:                   u8,
}
GPUMultisampleState :: struct {
	sample_count: GPUSampleCount,
	sample_mask:  u32,
	enable_mask:  b8,
	padding1:     u8,
	padding2:     u8,
	padding3:     u8,
}
GPUDepthStencilState :: struct {
	compare_op:          GPUCompareOp,
	back_stencil_state:  GPUStencilOpState,
	front_stencil_state: GPUStencilOpState,
	compare_mask:        u8,
	write_mask:          u8,
	enable_depth_test:   b8,
	enable_depth_write:  b8,
	enable_stencil_test: b8,
	padding1:            u8,
	padding2:            u8,
	padding3:            u8,
}
GPUColorTargetDescription :: struct {
	format:      GPUTextureFormat,
	blend_state: GPUColorTargetBlendState,
}
GPUGraphicsPipelineTargetInfo :: struct {
	color_target_descriptions: [^]GPUColorTargetDescription,
	num_color_targets:         u32,
	depth_stencil_format:      GPUTextureFormat,
	has_depth_stencil_target:  b8,
	padding1:                  u8,
	padding2:                  u8,
	padding3:                  u8,
}
GPUGraphicsPipelineCreateInfo :: struct {
	vertex_shader:       GPUShader,
	fragment_shader:     GPUShader,
	vertex_input_state:  GPUVertexInputState,
	primitive_type:      GPUPrimitiveType,
	rasterizer_state:    GPURasterizerState,
	multisample_state:   GPUMultisampleState,
	depth_stencil_state: GPUDepthStencilState,
	target_info:         GPUGraphicsPipelineTargetInfo,
	props:               PropertiesID,
}
GPUComputePipelineCreateInfo :: struct {
	code_size:                      u64,
	code:                           ^u8,
	entrypoint:                     cstring,
	format:                         GPUShaderFormat,
	num_samplers:                   u32,
	num_readonly_storage_textures:  u32,
	num_readonly_storage_buffers:   u32,
	num_readwrite_storage_textures: u32,
	num_readwrite_storage_buffers:  u32,
	num_uniform_buffers:            u32,
	threadcount_x:                  u32,
	threadcount_y:                  u32,
	threadcount_z:                  u32,
	props:                          PropertiesID,
}
GPUColorTargetInfo :: struct {
	texture:               GPUTexture,
	mip_level:             u32,
	layer_or_depth_plane:  u32,
	clear_color:           FColor,
	load_op:               GPULoadOp,
	store_op:              GPUStoreOp,
	resolve_texture:       GPUTexture,
	resolve_mip_level:     u32,
	resolve_layer:         u32,
	cycle:                 b8,
	cycle_resolve_texture: b8,
	padding1:              u8,
	padding2:              u8,
}
GPUDepthStencilTargetInfo :: struct {
	texture:          GPUTexture,
	clear_depth:      f32,
	load_op:          GPULoadOp,
	store_op:         GPUStoreOp,
	stencil_load_op:  GPULoadOp,
	stencil_store_op: GPUStoreOp,
	cycle:            b8,
	clear_stencil:    u8,
	padding1:         u8,
	padding2:         u8,
}
GPUBlitInfo :: struct {
	source:      GPUBlitRegion,
	destination: GPUBlitRegion,
	load_op:     GPULoadOp,
	clear_color: FColor,
	flip_mode:   FlipMode,
	filter:      GPUFilter,
	cycle:       b8,
	padding1:    u8,
	padding2:    u8,
	padding3:    u8,
}
GPUBufferBinding :: struct {
	buffer: GPUBuffer,
	offset: u32,
}
GPUTextureSamplerBinding :: struct {
	texture: GPUTexture,
	sampler: GPUSampler,
}
GPUStorageBufferReadWriteBinding :: struct {
	buffer:   GPUBuffer,
	cycle:    b8,
	padding1: u8,
	padding2: u8,
	padding3: u8,
}
GPUStorageTextureReadWriteBinding :: struct {
	texture:   GPUTexture,
	mip_level: u32,
	layer:     u32,
	cycle:     b8,
	padding1:  u8,
	padding2:  u8,
	padding3:  u8,
}
Haptic :: rawptr
HapticDirection :: struct {
	type: u8,
	dir:  [3]i32,
}
HapticConstant :: struct {
	type:          u16,
	direction:     HapticDirection,
	length:        u32,
	delay:         u16,
	button:        u16,
	interval:      u16,
	level:         i16,
	attack_length: u16,
	attack_level:  u16,
	fade_length:   u16,
	fade_level:    u16,
}
HapticPeriodic :: struct {
	type:          u16,
	direction:     HapticDirection,
	length:        u32,
	delay:         u16,
	button:        u16,
	interval:      u16,
	period:        u16,
	magnitude:     i16,
	offset:        i16,
	phase:         u16,
	attack_length: u16,
	attack_level:  u16,
	fade_length:   u16,
	fade_level:    u16,
}
HapticCondition :: struct {
	type:        u16,
	direction:   HapticDirection,
	length:      u32,
	delay:       u16,
	button:      u16,
	interval:    u16,
	right_sat:   [3]u16,
	left_sat:    [3]u16,
	right_coeff: [3]i16,
	left_coeff:  [3]i16,
	deadband:    [3]u16,
	center:      [3]i16,
}
HapticRamp :: struct {
	type:          u16,
	direction:     HapticDirection,
	length:        u32,
	delay:         u16,
	button:        u16,
	interval:      u16,
	start:         i16,
	end:           i16,
	attack_length: u16,
	attack_level:  u16,
	fade_length:   u16,
	fade_level:    u16,
}
HapticLeftRight :: struct {
	type:            u16,
	length:          u32,
	large_magnitude: u16,
	small_magnitude: u16,
}
HapticCustom :: struct {
	type:          u16,
	direction:     HapticDirection,
	length:        u32,
	delay:         u16,
	button:        u16,
	interval:      u16,
	channels:      u8,
	period:        u16,
	samples:       u16,
	data:          ^u16,
	attack_length: u16,
	attack_level:  u16,
	fade_length:   u16,
	fade_level:    u16,
}
HapticEffect :: struct #raw_union {
	type:      u16,
	constant:  HapticConstant,
	periodic:  HapticPeriodic,
	condition: HapticCondition,
	ramp:      HapticRamp,
	leftright: HapticLeftRight,
	custom:    HapticCustom,
}
HapticID :: u32
hid_device :: rawptr
hid_bus_type :: enum u32 {
	HID_API_BUS_UNKNOWN   = 0,
	HID_API_BUS_USB       = 1,
	HID_API_BUS_BLUETOOTH = 2,
	HID_API_BUS_I2C       = 3,
	HID_API_BUS_SPI       = 4,
}
hid_device_info :: struct {
	path:                cstring,
	vendor_id:           u16,
	product_id:          u16,
	serial_number:       ^i32,
	release_number:      u16,
	manufacturer_string: ^i32,
	product_string:      ^i32,
	usage_page:          u16,
	usage:               u16,
	interface_number:    i32,
	interface_class:     i32,
	interface_subclass:  i32,
	interface_protocol:  i32,
	bus_type:            hid_bus_type,
	next:                ^hid_device_info,
}
HintPriority :: enum u32 {
	HINT_DEFAULT  = 0,
	HINT_NORMAL   = 1,
	HINT_OVERRIDE = 2,
}
HintCallback :: #type proc "c" (
	userdata: rawptr,
	name: cstring,
	oldValue: cstring,
	newValue: cstring,
)
InitFlag :: enum u32 {
	TIMER          = 0x00,
	AUDIO          = 0x04,
	VIDEO          = 0x05,
	JOYSTICK       = 0x09,
	HAPTIC         = 0x0c,
	GAMECONTROLLER = 0x0d,
	EVENTS         = 0x0e,
	SENSOR         = 0x0f,
	NOPARACHUTE    = 0x14,
}

InitFlags :: u32

INIT_AUDIO :: 0x00000010 /**< `SDL_INIT_AUDIO` implies `SDL_INIT_EVENTS` */
INIT_VIDEO :: 0x00000020 /**< `SDL_INIT_VIDEO` implies `SDL_INIT_EVENTS` */
INIT_JOYSTICK :: 0x00000200 /**< `SDL_INIT_JOYSTICK` implies `SDL_INIT_EVENTS`, should be initialized on the same thread as SDL_INIT_VIDEO on Windows if you don't set SDL_HINT_JOYSTICK_THREAD */
INIT_HAPTIC :: 0x00001000
INIT_GAMEPAD :: 0x00002000 /**< `SDL_INIT_GAMEPAD` implies `SDL_INIT_JOYSTICK` */
INIT_EVENTS :: 0x00004000
INIT_SENSOR :: 0x00008000 /**< `SDL_INIT_SENSOR` implies `SDL_INIT_EVENTS` */
INIT_CAMERA :: 0x00010000 /**< `SDL_INIT_CAMERA` implies `SDL_INIT_EVENTS` */


AppResult :: enum u32 {
	APP_CONTINUE = 0,
	APP_SUCCESS  = 1,
	APP_FAILURE  = 2,
}
AppInit_func :: #type proc "c" (appstate: ^rawptr, argc: i32, argv: [^]cstring) -> AppResult
AppIterate_func :: #type proc "c" (appstate: rawptr) -> AppResult
AppEvent_func :: #type proc "c" (appstate: rawptr, event: ^Event) -> AppResult
AppQuit_func :: #type proc "c" (appstate: rawptr, result: AppResult)
SharedObject :: rawptr
Locale :: struct {
	language: cstring,
	country:  cstring,
}
LogCategory :: enum u32 {
	LOG_CATEGORY_APPLICATION = 0,
	LOG_CATEGORY_ERROR       = 1,
	LOG_CATEGORY_ASSERT      = 2,
	LOG_CATEGORY_SYSTEM      = 3,
	LOG_CATEGORY_AUDIO       = 4,
	LOG_CATEGORY_VIDEO       = 5,
	LOG_CATEGORY_RENDER      = 6,
	LOG_CATEGORY_INPUT       = 7,
	LOG_CATEGORY_TEST        = 8,
	LOG_CATEGORY_GPU         = 9,
	LOG_CATEGORY_RESERVED2   = 10,
	LOG_CATEGORY_RESERVED3   = 11,
	LOG_CATEGORY_RESERVED4   = 12,
	LOG_CATEGORY_RESERVED5   = 13,
	LOG_CATEGORY_RESERVED6   = 14,
	LOG_CATEGORY_RESERVED7   = 15,
	LOG_CATEGORY_RESERVED8   = 16,
	LOG_CATEGORY_RESERVED9   = 17,
	LOG_CATEGORY_RESERVED10  = 18,
	LOG_CATEGORY_CUSTOM      = 19,
}
LogPriority :: enum u32 {
	LOG_PRIORITY_INVALID  = 0,
	LOG_PRIORITY_TRACE    = 1,
	LOG_PRIORITY_VERBOSE  = 2,
	LOG_PRIORITY_DEBUG    = 3,
	LOG_PRIORITY_INFO     = 4,
	LOG_PRIORITY_WARN     = 5,
	LOG_PRIORITY_ERROR    = 6,
	LOG_PRIORITY_CRITICAL = 7,
	LOG_PRIORITY_COUNT    = 8,
}
LogOutputFunction :: #type proc "c" (
	userdata: rawptr,
	category: i32,
	priority: LogPriority,
	message: cstring,
)
MessageBoxFlags :: u32
MessageBoxButtonFlags :: u32
MessageBoxButtonData :: struct {
	flags:    MessageBoxButtonFlags,
	buttonID: i32,
	text:     cstring,
}
MessageBoxColor :: struct {
	r: u8,
	g: u8,
	b: u8,
}
MessageBoxColorType :: enum u32 {
	MESSAGEBOX_COLOR_BACKGROUND        = 0,
	MESSAGEBOX_COLOR_TEXT              = 1,
	MESSAGEBOX_COLOR_BUTTON_BORDER     = 2,
	MESSAGEBOX_COLOR_BUTTON_BACKGROUND = 3,
	MESSAGEBOX_COLOR_BUTTON_SELECTED   = 4,
	MESSAGEBOX_COLOR_COUNT             = 5,
}
MessageBoxColorScheme :: struct {
	colors: [5]MessageBoxColor,
}
MessageBoxData :: struct {
	flags:       MessageBoxFlags,
	window:      Window,
	title:       cstring,
	message:     cstring,
	numbuttons:  i32,
	buttons:     [^]MessageBoxButtonData,
	colorScheme: ^MessageBoxColorScheme,
}
MetalView :: rawptr
Process :: rawptr
ProcessIO :: enum u32 {
	PROCESS_STDIO_INHERITED = 0,
	PROCESS_STDIO_NULL      = 1,
	PROCESS_STDIO_APP       = 2,
	PROCESS_STDIO_REDIRECT  = 3,
}
Vertex :: struct {
	position:  FPoint,
	color:     FColor,
	tex_coord: FPoint,
}
TextureAccess :: enum u32 {
	TEXTUREACCESS_STATIC    = 0,
	TEXTUREACCESS_STREAMING = 1,
	TEXTUREACCESS_TARGET    = 2,
}
RendererLogicalPresentation :: enum u32 {
	LOGICAL_PRESENTATION_DISABLED      = 0,
	LOGICAL_PRESENTATION_STRETCH       = 1,
	LOGICAL_PRESENTATION_LETTERBOX     = 2,
	LOGICAL_PRESENTATION_OVERSCAN      = 3,
	LOGICAL_PRESENTATION_INTEGER_SCALE = 4,
}
Renderer :: rawptr
Texture :: struct {
	format:   PixelFormat,
	w:        i32,
	h:        i32,
	refcount: i32,
}
close_func_ptr_anon_20 :: #type proc "c" (userdata: rawptr) -> b8
ready_func_ptr_anon_21 :: #type proc "c" (userdata: rawptr) -> b8
enumerate_func_ptr_anon_22 :: #type proc "c" (
	userdata: rawptr,
	path: cstring,
	callback: EnumerateDirectoryCallback,
	callback_userdata: rawptr,
) -> b8
info_func_ptr_anon_23 :: #type proc "c" (userdata: rawptr, path: cstring, info: ^PathInfo) -> b8
read_file_func_ptr_anon_24 :: #type proc "c" (
	userdata: rawptr,
	path: cstring,
	destination: rawptr,
	length: u64,
) -> b8
write_file_func_ptr_anon_25 :: #type proc "c" (
	userdata: rawptr,
	path: cstring,
	source: rawptr,
	length: u64,
) -> b8
mkdir_func_ptr_anon_26 :: #type proc "c" (userdata: rawptr, path: cstring) -> b8
remove_func_ptr_anon_27 :: #type proc "c" (userdata: rawptr, path: cstring) -> b8
rename_func_ptr_anon_28 :: #type proc "c" (
	userdata: rawptr,
	oldpath: cstring,
	newpath: cstring,
) -> b8
copy_func_ptr_anon_29 :: #type proc "c" (
	userdata: rawptr,
	oldpath: cstring,
	newpath: cstring,
) -> b8
space_remaining_func_ptr_anon_30 :: #type proc "c" (userdata: rawptr) -> u64
StorageInterface :: struct {
	version:         u32,
	close:           close_func_ptr_anon_20,
	ready:           ready_func_ptr_anon_21,
	enumerate:       enumerate_func_ptr_anon_22,
	info:            info_func_ptr_anon_23,
	read_file:       read_file_func_ptr_anon_24,
	write_file:      write_file_func_ptr_anon_25,
	mkdir:           mkdir_func_ptr_anon_26,
	remove:          remove_func_ptr_anon_27,
	rename:          rename_func_ptr_anon_28,
	copy:            copy_func_ptr_anon_29,
	space_remaining: space_remaining_func_ptr_anon_30,
}
Storage :: rawptr
XEvent :: rawptr
X11EventHook :: #type proc "c" (userdata: rawptr, xevent: XEvent) -> b8
Sandbox :: enum u32 {
	SANDBOX_NONE              = 0,
	SANDBOX_UNKNOWN_CONTAINER = 1,
	SANDBOX_FLATPAK           = 2,
	SANDBOX_SNAP              = 3,
	SANDBOX_MACOS             = 4,
}
DateTime :: struct {
	year:        i32,
	month:       i32,
	day:         i32,
	hour:        i32,
	minute:      i32,
	second:      i32,
	nanosecond:  i32,
	day_of_week: i32,
	utc_offset:  i32,
}
DateFormat :: enum u32 {
	DATE_FORMAT_YYYYMMDD = 0,
	DATE_FORMAT_DDMMYYYY = 1,
	DATE_FORMAT_MMDDYYYY = 2,
}
TimeFormat :: enum u32 {
	TIME_FORMAT_24HR = 0,
	TIME_FORMAT_12HR = 1,
}
TimerID :: u32
TimerCallback :: #type proc "c" (userdata: rawptr, timerID: TimerID, interval: u32) -> u32
NSTimerCallback :: #type proc "c" (userdata: rawptr, timerID: TimerID, interval: u64) -> u64

foreign import sdl3_runic "system:SDL3"

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign sdl3_runic {
	ReportAssertion :: proc(data: ^AssertData, func: cstring, file: cstring, line: i32) -> AssertState ---
	SetAssertionHandler :: proc(handler: AssertionHandler, userdata: rawptr) ---
	GetDefaultAssertionHandler :: proc() -> AssertionHandler ---
	GetAssertionHandler :: proc(puserdata: ^rawptr) -> AssertionHandler ---
	GetAssertionReport :: proc() -> ^AssertData ---
	ResetAssertionReport :: proc() ---
	TryLockSpinlock :: proc(lock: ^SpinLock) -> b8 ---
	LockSpinlock :: proc(lock: ^SpinLock) ---
	UnlockSpinlock :: proc(lock: ^SpinLock) ---
	MemoryBarrierReleaseFunction :: proc() ---
	MemoryBarrierAcquireFunction :: proc() ---
	CompareAndSwapAtomicInt :: proc(a: ^AtomicInt, oldval: i32, newval: i32) -> b8 ---
	SetAtomicInt :: proc(a: ^AtomicInt, v: i32) -> i32 ---
	GetAtomicInt :: proc(a: ^AtomicInt) -> i32 ---
	AddAtomicInt :: proc(a: ^AtomicInt, v: i32) -> i32 ---
	CompareAndSwapAtomicU32 :: proc(a: ^AtomicU32, oldval: u32, newval: u32) -> b8 ---
	SetAtomicU32 :: proc(a: ^AtomicU32, v: u32) -> u32 ---
	GetAtomicU32 :: proc(a: ^AtomicU32) -> u32 ---
	CompareAndSwapAtomicPointer :: proc(a: ^rawptr, oldval: rawptr, newval: rawptr) -> b8 ---
	SetAtomicPointer :: proc(a: ^rawptr, v: rawptr) -> rawptr ---
	GetAtomicPointer :: proc(a: ^rawptr) -> rawptr ---
	SetError :: proc(fmt: cstring, #c_vararg var_args: ..any) -> b8 ---
	SetErrorV :: proc(fmt: cstring, #c_vararg var_args: ..any) -> b8 ---
	OutOfMemory :: proc() -> b8 ---
	GetError :: proc() -> cstring ---
	ClearError :: proc() -> b8 ---
	GetGlobalProperties :: proc() -> PropertiesID ---
	CreateProperties :: proc() -> PropertiesID ---
	CopyProperties :: proc(src: PropertiesID, dst: PropertiesID) -> b8 ---
	LockProperties :: proc(props: PropertiesID) -> b8 ---
	UnlockProperties :: proc(props: PropertiesID) ---
	SetPointerPropertyWithCleanup :: proc(props: PropertiesID, name: cstring, value: rawptr, cleanup: CleanupPropertyCallback, userdata: rawptr) -> b8 ---
	SetPointerProperty :: proc(props: PropertiesID, name: cstring, value: rawptr) -> b8 ---
	SetStringProperty :: proc(props: PropertiesID, name: cstring, value: cstring) -> b8 ---
	SetNumberProperty :: proc(props: PropertiesID, name: cstring, value: i64) -> b8 ---
	SetFloatProperty :: proc(props: PropertiesID, name: cstring, value: f32) -> b8 ---
	SetBooleanProperty :: proc(props: PropertiesID, name: cstring, value: b8) -> b8 ---
	HasProperty :: proc(props: PropertiesID, name: cstring) -> b8 ---
	GetPropertyType :: proc(props: PropertiesID, name: cstring) -> PropertyType ---
	GetPointerProperty :: proc(props: PropertiesID, name: cstring, default_value: rawptr) -> rawptr ---
	GetStringProperty :: proc(props: PropertiesID, name: cstring, default_value: cstring) -> cstring ---
	GetNumberProperty :: proc(props: PropertiesID, name: cstring, default_value: i64) -> i64 ---
	GetFloatProperty :: proc(props: PropertiesID, name: cstring, default_value: f32) -> f32 ---
	GetBooleanProperty :: proc(props: PropertiesID, name: cstring, default_value: b8) -> b8 ---
	ClearProperty :: proc(props: PropertiesID, name: cstring) -> b8 ---
	EnumerateProperties :: proc(props: PropertiesID, callback: EnumeratePropertiesCallback, userdata: rawptr) -> b8 ---
	DestroyProperties :: proc(props: PropertiesID) ---
	CreateThreadRuntime :: proc(fn: ThreadFunction, name: cstring, data: rawptr, pfnBeginThread: #type proc "c" (), pfnEndThread: #type proc "c" ()) -> Thread ---
	CreateThreadWithPropertiesRuntime :: proc(props: PropertiesID, pfnBeginThread: #type proc "c" (), pfnEndThread: #type proc "c" ()) -> Thread ---
	GetThreadName :: proc(thread: Thread) -> cstring ---
	GetCurrentThreadID :: proc() -> ThreadID ---
	GetThreadID :: proc(thread: Thread) -> ThreadID ---
	SetCurrentThreadPriority :: proc(priority: ThreadPriority) -> b8 ---
	WaitThread :: proc(thread: Thread, status: [^]i32) ---
	DetachThread :: proc(thread: Thread) ---
	GetTLS :: proc(id: ^TLSID) -> rawptr ---
	SetTLS :: proc(id: ^TLSID, value: rawptr, destructor: TLSDestructorCallback) -> b8 ---
	CleanupTLS :: proc() ---
	CreateMutex :: proc() -> Mutex ---
	LockMutex :: proc(mutex: Mutex) ---
	TryLockMutex :: proc(mutex: Mutex) -> b8 ---
	UnlockMutex :: proc(mutex: Mutex) ---
	DestroyMutex :: proc(mutex: Mutex) ---
	CreateRWLock :: proc() -> RWLock ---
	LockRWLockForReading :: proc(rwlock: RWLock) ---
	LockRWLockForWriting :: proc(rwlock: RWLock) ---
	TryLockRWLockForReading :: proc(rwlock: RWLock) -> b8 ---
	TryLockRWLockForWriting :: proc(rwlock: RWLock) -> b8 ---
	UnlockRWLock :: proc(rwlock: RWLock) ---
	DestroyRWLock :: proc(rwlock: RWLock) ---
	CreateSemaphore :: proc(initial_value: u32) -> Semaphore ---
	DestroySemaphore :: proc(sem: Semaphore) ---
	WaitSemaphore :: proc(sem: Semaphore) ---
	TryWaitSemaphore :: proc(sem: Semaphore) -> b8 ---
	WaitSemaphoreTimeout :: proc(sem: Semaphore, timeoutMS: i32) -> b8 ---
	SignalSemaphore :: proc(sem: Semaphore) ---
	GetSemaphoreValue :: proc(sem: Semaphore) -> u32 ---
	CreateCondition :: proc() -> Condition ---
	DestroyCondition :: proc(cond: Condition) ---
	SignalCondition :: proc(cond: Condition) ---
	BroadcastCondition :: proc(cond: Condition) ---
	WaitCondition :: proc(cond: Condition, mutex: Mutex) ---
	WaitConditionTimeout :: proc(cond: Condition, mutex: Mutex, timeoutMS: i32) -> b8 ---
	ShouldInit :: proc(state: ^InitState) -> b8 ---
	ShouldQuit :: proc(state: ^InitState) -> b8 ---
	SetInitialized :: proc(state: ^InitState, initialized: b8) ---
	IOFromFile :: proc(file: cstring, mode: cstring) -> IOStream ---
	IOFromMem :: proc(mem: rawptr, size: u64) -> IOStream ---
	IOFromConstMem :: proc(mem: rawptr, size: u64) -> IOStream ---
	IOFromDynamicMem :: proc() -> IOStream ---
	OpenIO :: proc(iface: ^IOStreamInterface, userdata: rawptr) -> IOStream ---
	CloseIO :: proc(context_p: IOStream) -> b8 ---
	GetIOProperties :: proc(context_p: IOStream) -> PropertiesID ---
	GetIOStatus :: proc(context_p: IOStream) -> IOStatus ---
	GetIOSize :: proc(context_p: IOStream) -> i64 ---
	SeekIO :: proc(context_p: IOStream, offset: i64, whence: IOWhence) -> i64 ---
	TellIO :: proc(context_p: IOStream) -> i64 ---
	ReadIO :: proc(context_p: IOStream, ptr: rawptr, size: u64) -> u64 ---
	WriteIO :: proc(context_p: IOStream, ptr: rawptr, size: u64) -> u64 ---
	IOprintf :: proc(context_p: IOStream, fmt: cstring, #c_vararg var_args: ..any) -> u64 ---
	IOvprintf :: proc(context_p: IOStream, fmt: cstring, #c_vararg var_args: ..any) -> u64 ---
	FlushIO :: proc(context_p: IOStream) -> b8 ---
	LoadFile_IO :: proc(src: IOStream, datasize: ^u64, closeio: b8) -> rawptr ---
	LoadFile :: proc(file: cstring, datasize: ^u64) -> rawptr ---
	SaveFile_IO :: proc(src: IOStream, data: rawptr, datasize: u64, closeio: b8) -> b8 ---
	SaveFile :: proc(file: cstring, data: rawptr, datasize: u64) -> b8 ---
	ReadU8 :: proc(src: IOStream, value: ^u8) -> b8 ---
	ReadS8 :: proc(src: IOStream, value: ^i8) -> b8 ---
	ReadU16LE :: proc(src: IOStream, value: ^u16) -> b8 ---
	ReadS16LE :: proc(src: IOStream, value: ^i16) -> b8 ---
	ReadU16BE :: proc(src: IOStream, value: ^u16) -> b8 ---
	ReadS16BE :: proc(src: IOStream, value: ^i16) -> b8 ---
	ReadU32LE :: proc(src: IOStream, value: ^u32) -> b8 ---
	ReadS32LE :: proc(src: IOStream, value: ^i32) -> b8 ---
	ReadU32BE :: proc(src: IOStream, value: ^u32) -> b8 ---
	ReadS32BE :: proc(src: IOStream, value: ^i32) -> b8 ---
	ReadU64LE :: proc(src: IOStream, value: ^u64) -> b8 ---
	ReadS64LE :: proc(src: IOStream, value: ^i64) -> b8 ---
	ReadU64BE :: proc(src: IOStream, value: ^u64) -> b8 ---
	ReadS64BE :: proc(src: IOStream, value: ^i64) -> b8 ---
	WriteU8 :: proc(dst: IOStream, value: u8) -> b8 ---
	WriteS8 :: proc(dst: IOStream, value: i8) -> b8 ---
	WriteU16LE :: proc(dst: IOStream, value: u16) -> b8 ---
	WriteS16LE :: proc(dst: IOStream, value: i16) -> b8 ---
	WriteU16BE :: proc(dst: IOStream, value: u16) -> b8 ---
	WriteS16BE :: proc(dst: IOStream, value: i16) -> b8 ---
	WriteU32LE :: proc(dst: IOStream, value: u32) -> b8 ---
	WriteS32LE :: proc(dst: IOStream, value: i32) -> b8 ---
	WriteU32BE :: proc(dst: IOStream, value: u32) -> b8 ---
	WriteS32BE :: proc(dst: IOStream, value: i32) -> b8 ---
	WriteU64LE :: proc(dst: IOStream, value: u64) -> b8 ---
	WriteS64LE :: proc(dst: IOStream, value: i64) -> b8 ---
	WriteU64BE :: proc(dst: IOStream, value: u64) -> b8 ---
	WriteS64BE :: proc(dst: IOStream, value: i64) -> b8 ---
	GetNumAudioDrivers :: proc() -> i32 ---
	GetAudioDriver :: proc(index: i32) -> cstring ---
	GetCurrentAudioDriver :: proc() -> cstring ---
	GetAudioPlaybackDevices :: proc(count: ^i32) -> ^AudioDeviceID ---
	GetAudioRecordingDevices :: proc(count: ^i32) -> ^AudioDeviceID ---
	GetAudioDeviceName :: proc(devid: AudioDeviceID) -> cstring ---
	GetAudioDeviceFormat :: proc(devid: AudioDeviceID, spec: ^AudioSpec, sample_frames: [^]i32) -> b8 ---
	GetAudioDeviceChannelMap :: proc(devid: AudioDeviceID, count: ^i32) -> ^i32 ---
	OpenAudioDevice :: proc(devid: AudioDeviceID, spec: ^AudioSpec) -> AudioDeviceID ---
	PauseAudioDevice :: proc(dev: AudioDeviceID) -> b8 ---
	ResumeAudioDevice :: proc(dev: AudioDeviceID) -> b8 ---
	AudioDevicePaused :: proc(dev: AudioDeviceID) -> b8 ---
	GetAudioDeviceGain :: proc(devid: AudioDeviceID) -> f32 ---
	SetAudioDeviceGain :: proc(devid: AudioDeviceID, gain: f32) -> b8 ---
	CloseAudioDevice :: proc(devid: AudioDeviceID) ---
	BindAudioStreams :: proc(devid: AudioDeviceID, streams: ^[^]AudioStream, num_streams: i32) -> b8 ---
	BindAudioStream :: proc(devid: AudioDeviceID, stream: AudioStream) -> b8 ---
	UnbindAudioStreams :: proc(streams: ^[^]AudioStream, num_streams: i32) ---
	UnbindAudioStream :: proc(stream: AudioStream) ---
	GetAudioStreamDevice :: proc(stream: AudioStream) -> AudioDeviceID ---
	CreateAudioStream :: proc(src_spec: ^AudioSpec, dst_spec: ^AudioSpec) -> AudioStream ---
	GetAudioStreamProperties :: proc(stream: AudioStream) -> PropertiesID ---
	GetAudioStreamFormat :: proc(stream: AudioStream, src_spec: ^AudioSpec, dst_spec: ^AudioSpec) -> b8 ---
	SetAudioStreamFormat :: proc(stream: AudioStream, src_spec: ^AudioSpec, dst_spec: ^AudioSpec) -> b8 ---
	GetAudioStreamFrequencyRatio :: proc(stream: AudioStream) -> f32 ---
	SetAudioStreamFrequencyRatio :: proc(stream: AudioStream, ratio: f32) -> b8 ---
	GetAudioStreamGain :: proc(stream: AudioStream) -> f32 ---
	SetAudioStreamGain :: proc(stream: AudioStream, gain: f32) -> b8 ---
	GetAudioStreamInputChannelMap :: proc(stream: AudioStream, count: ^i32) -> ^i32 ---
	GetAudioStreamOutputChannelMap :: proc(stream: AudioStream, count: ^i32) -> ^i32 ---
	SetAudioStreamInputChannelMap :: proc(stream: AudioStream, chmap: ^i32, count: i32) -> b8 ---
	SetAudioStreamOutputChannelMap :: proc(stream: AudioStream, chmap: ^i32, count: i32) -> b8 ---
	PutAudioStreamData :: proc(stream: AudioStream, buf: rawptr, len: i32) -> b8 ---
	GetAudioStreamData :: proc(stream: AudioStream, buf: rawptr, len: i32) -> i32 ---
	GetAudioStreamAvailable :: proc(stream: AudioStream) -> i32 ---
	GetAudioStreamQueued :: proc(stream: AudioStream) -> i32 ---
	FlushAudioStream :: proc(stream: AudioStream) -> b8 ---
	ClearAudioStream :: proc(stream: AudioStream) -> b8 ---
	PauseAudioStreamDevice :: proc(stream: AudioStream) -> b8 ---
	ResumeAudioStreamDevice :: proc(stream: AudioStream) -> b8 ---
	LockAudioStream :: proc(stream: AudioStream) -> b8 ---
	UnlockAudioStream :: proc(stream: AudioStream) -> b8 ---
	SetAudioStreamGetCallback :: proc(stream: AudioStream, callback: AudioStreamCallback, userdata: rawptr) -> b8 ---
	SetAudioStreamPutCallback :: proc(stream: AudioStream, callback: AudioStreamCallback, userdata: rawptr) -> b8 ---
	DestroyAudioStream :: proc(stream: AudioStream) ---
	OpenAudioDeviceStream :: proc(devid: AudioDeviceID, spec: ^AudioSpec, callback: AudioStreamCallback, userdata: rawptr) -> AudioStream ---
	SetAudioPostmixCallback :: proc(devid: AudioDeviceID, callback: AudioPostmixCallback, userdata: rawptr) -> b8 ---
	LoadWAV_IO :: proc(src: IOStream, closeio: b8, spec: ^AudioSpec, audio_buf: ^^u8, audio_len: ^u32) -> b8 ---
	LoadWAV :: proc(path: cstring, spec: ^AudioSpec, audio_buf: ^^u8, audio_len: ^u32) -> b8 ---
	MixAudio :: proc(dst: ^u8, src: ^u8, format: AudioFormat, len: u32, volume: f32) -> b8 ---
	ConvertAudioSamples :: proc(src_spec: ^AudioSpec, src_data: ^u8, src_len: i32, dst_spec: ^AudioSpec, dst_data: ^^u8, dst_len: ^i32) -> b8 ---
	GetAudioFormatName :: proc(format: AudioFormat) -> cstring ---
	GetSilenceValueForFormat :: proc(format: AudioFormat) -> i32 ---
	ComposeCustomBlendMode :: proc(srcColorFactor: BlendFactor, dstColorFactor: BlendFactor, colorOperation: BlendOperation, srcAlphaFactor: BlendFactor, dstAlphaFactor: BlendFactor, alphaOperation: BlendOperation) -> BlendMode ---
	GetPixelFormatName :: proc(format: PixelFormat) -> cstring ---
	GetMasksForPixelFormat :: proc(format: PixelFormat, bpp: ^i32, Rmask: ^u32, Gmask: ^u32, Bmask: ^u32, Amask: ^u32) -> b8 ---
	GetPixelFormatForMasks :: proc(bpp: i32, Rmask: u32, Gmask: u32, Bmask: u32, Amask: u32) -> PixelFormat ---
	GetPixelFormatDetails :: proc(format: PixelFormat) -> ^PixelFormatDetails ---
	CreatePalette :: proc(ncolors: i32) -> ^Palette ---
	SetPaletteColors :: proc(palette: ^Palette, colors: [^]Color, firstcolor: i32, ncolors: i32) -> b8 ---
	DestroyPalette :: proc(palette: ^Palette) ---
	MapRGB :: proc(format: ^PixelFormatDetails, palette: ^Palette, r: u8, g: u8, b: u8) -> u32 ---
	MapRGBA :: proc(format: ^PixelFormatDetails, palette: ^Palette, r: u8, g: u8, b: u8, a: u8) -> u32 ---
	GetRGB :: proc(pixel: u32, format: ^PixelFormatDetails, palette: ^Palette, r: ^u8, g: ^u8, b: ^u8) ---
	GetRGBA :: proc(pixel: u32, format: ^PixelFormatDetails, palette: ^Palette, r: ^u8, g: ^u8, b: ^u8, a: ^u8) ---
	HasRectIntersection :: proc(A: ^Rect, B: ^Rect) -> b8 ---
	GetRectIntersection :: proc(A: ^Rect, B: ^Rect, result: ^Rect) -> b8 ---
	GetRectUnion :: proc(A: ^Rect, B: ^Rect, result: ^Rect) -> b8 ---
	GetRectEnclosingPoints :: proc(points: [^]Point, count: i32, clip: ^Rect, result: ^Rect) -> b8 ---
	GetRectAndLineIntersection :: proc(rect: ^Rect, X1: ^i32, Y1: ^i32, X2: ^i32, Y2: ^i32) -> b8 ---
	HasRectIntersectionFloat :: proc(A: ^FRect, B: ^FRect) -> b8 ---
	GetRectIntersectionFloat :: proc(A: ^FRect, B: ^FRect, result: ^FRect) -> b8 ---
	GetRectUnionFloat :: proc(A: ^FRect, B: ^FRect, result: ^FRect) -> b8 ---
	GetRectEnclosingPointsFloat :: proc(points: [^]FPoint, count: i32, clip: ^FRect, result: ^FRect) -> b8 ---
	GetRectAndLineIntersectionFloat :: proc(rect: ^FRect, X1: ^f32, Y1: ^f32, X2: ^f32, Y2: ^f32) -> b8 ---
	CreateSurface :: proc(width: i32, height: i32, format: PixelFormat) -> ^Surface ---
	CreateSurfaceFrom :: proc(width: i32, height: i32, format: PixelFormat, pixels: rawptr, pitch: i32) -> ^Surface ---
	DestroySurface :: proc(surface: ^Surface) ---
	GetSurfaceProperties :: proc(surface: ^Surface) -> PropertiesID ---
	SetSurfaceColorspace :: proc(surface: ^Surface, colorspace: Colorspace) -> b8 ---
	GetSurfaceColorspace :: proc(surface: ^Surface) -> Colorspace ---
	CreateSurfacePalette :: proc(surface: ^Surface) -> ^Palette ---
	SetSurfacePalette :: proc(surface: ^Surface, palette: ^Palette) -> b8 ---
	GetSurfacePalette :: proc(surface: ^Surface) -> ^Palette ---
	AddSurfaceAlternateImage :: proc(surface: ^Surface, image: ^Surface) -> b8 ---
	SurfaceHasAlternateImages :: proc(surface: ^Surface) -> b8 ---
	GetSurfaceImages :: proc(surface: ^Surface, count: ^i32) -> ^^Surface ---
	RemoveSurfaceAlternateImages :: proc(surface: ^Surface) ---
	LockSurface :: proc(surface: ^Surface) -> b8 ---
	UnlockSurface :: proc(surface: ^Surface) ---
	LoadBMP_IO :: proc(src: IOStream, closeio: b8) -> ^Surface ---
	LoadBMP :: proc(file: cstring) -> ^Surface ---
	SaveBMP_IO :: proc(surface: ^Surface, dst: IOStream, closeio: b8) -> b8 ---
	SaveBMP :: proc(surface: ^Surface, file: cstring) -> b8 ---
	SetSurfaceRLE :: proc(surface: ^Surface, enabled: b8) -> b8 ---
	SurfaceHasRLE :: proc(surface: ^Surface) -> b8 ---
	SetSurfaceColorKey :: proc(surface: ^Surface, enabled: b8, key: u32) -> b8 ---
	SurfaceHasColorKey :: proc(surface: ^Surface) -> b8 ---
	GetSurfaceColorKey :: proc(surface: ^Surface, key: ^u32) -> b8 ---
	SetSurfaceColorMod :: proc(surface: ^Surface, r: u8, g: u8, b: u8) -> b8 ---
	GetSurfaceColorMod :: proc(surface: ^Surface, r: ^u8, g: ^u8, b: ^u8) -> b8 ---
	SetSurfaceAlphaMod :: proc(surface: ^Surface, alpha: u8) -> b8 ---
	GetSurfaceAlphaMod :: proc(surface: ^Surface, alpha: ^u8) -> b8 ---
	SetSurfaceBlendMode :: proc(surface: ^Surface, blendMode: BlendMode) -> b8 ---
	GetSurfaceBlendMode :: proc(surface: ^Surface, blendMode: ^BlendMode) -> b8 ---
	SetSurfaceClipRect :: proc(surface: ^Surface, rect: ^Rect) -> b8 ---
	GetSurfaceClipRect :: proc(surface: ^Surface, rect: ^Rect) -> b8 ---
	FlipSurface :: proc(surface: ^Surface, flip: FlipMode) -> b8 ---
	DuplicateSurface :: proc(surface: ^Surface) -> ^Surface ---
	ScaleSurface :: proc(surface: ^Surface, width: i32, height: i32, scaleMode: ScaleMode) -> ^Surface ---
	ConvertSurface :: proc(surface: ^Surface, format: PixelFormat) -> ^Surface ---
	ConvertSurfaceAndColorspace :: proc(surface: ^Surface, format: PixelFormat, palette: ^Palette, colorspace: Colorspace, props: PropertiesID) -> ^Surface ---
	ConvertPixels :: proc(width: i32, height: i32, src_format: PixelFormat, src: rawptr, src_pitch: i32, dst_format: PixelFormat, dst: rawptr, dst_pitch: i32) -> b8 ---
	ConvertPixelsAndColorspace :: proc(width: i32, height: i32, src_format: PixelFormat, src_colorspace: Colorspace, src_properties: PropertiesID, src: rawptr, src_pitch: i32, dst_format: PixelFormat, dst_colorspace: Colorspace, dst_properties: PropertiesID, dst: rawptr, dst_pitch: i32) -> b8 ---
	PremultiplyAlpha :: proc(width: i32, height: i32, src_format: PixelFormat, src: rawptr, src_pitch: i32, dst_format: PixelFormat, dst: rawptr, dst_pitch: i32, linear: b8) -> b8 ---
	PremultiplySurfaceAlpha :: proc(surface: ^Surface, linear: b8) -> b8 ---
	ClearSurface :: proc(surface: ^Surface, r: f32, g: f32, b: f32, a: f32) -> b8 ---
	FillSurfaceRect :: proc(dst: ^Surface, rect: ^Rect, color: u32) -> b8 ---
	FillSurfaceRects :: proc(dst: ^Surface, rects: [^]Rect, count: i32, color: u32) -> b8 ---
	BlitSurface :: proc(src: ^Surface, srcrect: ^Rect, dst: ^Surface, dstrect: ^Rect) -> b8 ---
	BlitSurfaceUnchecked :: proc(src: ^Surface, srcrect: ^Rect, dst: ^Surface, dstrect: ^Rect) -> b8 ---
	BlitSurfaceScaled :: proc(src: ^Surface, srcrect: ^Rect, dst: ^Surface, dstrect: ^Rect, scaleMode: ScaleMode) -> b8 ---
	BlitSurfaceUncheckedScaled :: proc(src: ^Surface, srcrect: ^Rect, dst: ^Surface, dstrect: ^Rect, scaleMode: ScaleMode) -> b8 ---
	BlitSurfaceTiled :: proc(src: ^Surface, srcrect: ^Rect, dst: ^Surface, dstrect: ^Rect) -> b8 ---
	BlitSurfaceTiledWithScale :: proc(src: ^Surface, srcrect: ^Rect, scale: f32, scaleMode: ScaleMode, dst: ^Surface, dstrect: ^Rect) -> b8 ---
	BlitSurface9Grid :: proc(src: ^Surface, srcrect: ^Rect, left_width: i32, right_width: i32, top_height: i32, bottom_height: i32, scale: f32, scaleMode: ScaleMode, dst: ^Surface, dstrect: ^Rect) -> b8 ---
	MapSurfaceRGB :: proc(surface: ^Surface, r: u8, g: u8, b: u8) -> u32 ---
	MapSurfaceRGBA :: proc(surface: ^Surface, r: u8, g: u8, b: u8, a: u8) -> u32 ---
	ReadSurfacePixel :: proc(surface: ^Surface, x: i32, y: i32, r: ^u8, g: ^u8, b: ^u8, a: ^u8) -> b8 ---
	ReadSurfacePixelFloat :: proc(surface: ^Surface, x: i32, y: i32, r: ^f32, g: ^f32, b: ^f32, a: ^f32) -> b8 ---
	WriteSurfacePixel :: proc(surface: ^Surface, x: i32, y: i32, r: u8, g: u8, b: u8, a: u8) -> b8 ---
	WriteSurfacePixelFloat :: proc(surface: ^Surface, x: i32, y: i32, r: f32, g: f32, b: f32, a: f32) -> b8 ---
	GetNumCameraDrivers :: proc() -> i32 ---
	GetCameraDriver :: proc(index: i32) -> cstring ---
	GetCurrentCameraDriver :: proc() -> cstring ---
	GetCameras :: proc(count: ^i32) -> ^CameraID ---
	GetCameraSupportedFormats :: proc(devid: CameraID, count: ^i32) -> ^^CameraSpec ---
	GetCameraName :: proc(instance_id: CameraID) -> cstring ---
	GetCameraPosition :: proc(instance_id: CameraID) -> CameraPosition ---
	OpenCamera :: proc(instance_id: CameraID, spec: ^CameraSpec) -> Camera ---
	GetCameraPermissionState :: proc(camera: Camera) -> i32 ---
	GetCameraID :: proc(camera: Camera) -> CameraID ---
	GetCameraProperties :: proc(camera: Camera) -> PropertiesID ---
	GetCameraFormat :: proc(camera: Camera, spec: ^CameraSpec) -> b8 ---
	AcquireCameraFrame :: proc(camera: Camera, timestampNS: ^u64) -> ^Surface ---
	ReleaseCameraFrame :: proc(camera: Camera, frame: ^Surface) ---
	CloseCamera :: proc(camera: Camera) ---
	SetClipboardText :: proc(text: cstring) -> b8 ---
	GetClipboardText :: proc() -> cstring ---
	HasClipboardText :: proc() -> b8 ---
	SetPrimarySelectionText :: proc(text: cstring) -> b8 ---
	GetPrimarySelectionText :: proc() -> cstring ---
	HasPrimarySelectionText :: proc() -> b8 ---
	SetClipboardData :: proc(callback: ClipboardDataCallback, cleanup: ClipboardCleanupCallback, userdata: rawptr, mime_types: [^]cstring, num_mime_types: u64) -> b8 ---
	ClearClipboardData :: proc() -> b8 ---
	GetClipboardData :: proc(mime_type: cstring, size: ^u64) -> rawptr ---
	HasClipboardData :: proc(mime_type: cstring) -> b8 ---
	GetClipboardMimeTypes :: proc(num_mime_types: [^]u64) -> ^cstring ---
	GetNumLogicalCPUCores :: proc() -> i32 ---
	GetCPUCacheLineSize :: proc() -> i32 ---
	HasAltiVec :: proc() -> b8 ---
	HasMMX :: proc() -> b8 ---
	HasSSE :: proc() -> b8 ---
	HasSSE2 :: proc() -> b8 ---
	HasSSE3 :: proc() -> b8 ---
	HasSSE41 :: proc() -> b8 ---
	HasSSE42 :: proc() -> b8 ---
	HasAVX :: proc() -> b8 ---
	HasAVX2 :: proc() -> b8 ---
	HasAVX512F :: proc() -> b8 ---
	HasARMSIMD :: proc() -> b8 ---
	HasNEON :: proc() -> b8 ---
	HasLSX :: proc() -> b8 ---
	HasLASX :: proc() -> b8 ---
	GetSystemRAM :: proc() -> i32 ---
	GetSIMDAlignment :: proc() -> u64 ---
	GetNumVideoDrivers :: proc() -> i32 ---
	GetVideoDriver :: proc(index: i32) -> cstring ---
	GetCurrentVideoDriver :: proc() -> cstring ---
	GetSystemTheme :: proc() -> SystemTheme ---
	GetDisplays :: proc(count: ^i32) -> ^DisplayID ---
	GetPrimaryDisplay :: proc() -> DisplayID ---
	GetDisplayProperties :: proc(displayID: DisplayID) -> PropertiesID ---
	GetDisplayName :: proc(displayID: DisplayID) -> cstring ---
	GetDisplayBounds :: proc(displayID: DisplayID, rect: ^Rect) -> b8 ---
	GetDisplayUsableBounds :: proc(displayID: DisplayID, rect: ^Rect) -> b8 ---
	GetNaturalDisplayOrientation :: proc(displayID: DisplayID) -> DisplayOrientation ---
	GetCurrentDisplayOrientation :: proc(displayID: DisplayID) -> DisplayOrientation ---
	GetDisplayContentScale :: proc(displayID: DisplayID) -> f32 ---
	GetFullscreenDisplayModes :: proc(displayID: DisplayID, count: ^i32) -> ^^DisplayMode ---
	GetClosestFullscreenDisplayMode :: proc(displayID: DisplayID, w: i32, h: i32, refresh_rate: f32, include_high_density_modes: b8, closest: ^DisplayMode) -> b8 ---
	GetDesktopDisplayMode :: proc(displayID: DisplayID) -> ^DisplayMode ---
	GetCurrentDisplayMode :: proc(displayID: DisplayID) -> ^DisplayMode ---
	GetDisplayForPoint :: proc(point: ^Point) -> DisplayID ---
	GetDisplayForRect :: proc(rect: ^Rect) -> DisplayID ---
	GetDisplayForWindow :: proc(window: Window) -> DisplayID ---
	GetWindowPixelDensity :: proc(window: Window) -> f32 ---
	GetWindowDisplayScale :: proc(window: Window) -> f32 ---
	SetWindowFullscreenMode :: proc(window: Window, mode: ^DisplayMode) -> b8 ---
	GetWindowFullscreenMode :: proc(window: Window) -> ^DisplayMode ---
	GetWindowICCProfile :: proc(window: Window, size: ^u64) -> rawptr ---
	GetWindowPixelFormat :: proc(window: Window) -> PixelFormat ---
	GetWindows :: proc(count: ^i32) -> [^]Window ---
	CreateWindow :: proc(title: cstring, w: i32, h: i32, flags: WindowFlags) -> Window ---
	CreatePopupWindow :: proc(parent: Window, offset_x: i32, offset_y: i32, w: i32, h: i32, flags: WindowFlags) -> Window ---
	CreateWindowWithProperties :: proc(props: PropertiesID) -> Window ---
	GetWindowID :: proc(window: Window) -> WindowID ---
	GetWindowFromID :: proc(id: WindowID) -> Window ---
	GetWindowParent :: proc(window: Window) -> Window ---
	GetWindowProperties :: proc(window: Window) -> PropertiesID ---
	GetWindowFlags :: proc(window: Window) -> WindowFlags ---
	SetWindowTitle :: proc(window: Window, title: cstring) -> b8 ---
	GetWindowTitle :: proc(window: Window) -> cstring ---
	SetWindowIcon :: proc(window: Window, icon: ^Surface) -> b8 ---
	SetWindowPosition :: proc(window: Window, x: i32, y: i32) -> b8 ---
	GetWindowPosition :: proc(window: Window, x: ^i32, y: ^i32) -> b8 ---
	SetWindowSize :: proc(window: Window, w: i32, h: i32) -> b8 ---
	GetWindowSize :: proc(window: Window, w: ^i32, h: ^i32) -> b8 ---
	GetWindowSafeArea :: proc(window: Window, rect: ^Rect) -> b8 ---
	SetWindowAspectRatio :: proc(window: Window, min_aspect: f32, max_aspect: f32) -> b8 ---
	GetWindowAspectRatio :: proc(window: Window, min_aspect: ^f32, max_aspect: ^f32) -> b8 ---
	GetWindowBordersSize :: proc(window: Window, top: ^i32, left: ^i32, bottom: ^i32, right: ^i32) -> b8 ---
	GetWindowSizeInPixels :: proc(window: Window, w: ^i32, h: ^i32) -> b8 ---
	SetWindowMinimumSize :: proc(window: Window, min_w: i32, min_h: i32) -> b8 ---
	GetWindowMinimumSize :: proc(window: Window, w: ^i32, h: ^i32) -> b8 ---
	SetWindowMaximumSize :: proc(window: Window, max_w: i32, max_h: i32) -> b8 ---
	GetWindowMaximumSize :: proc(window: Window, w: ^i32, h: ^i32) -> b8 ---
	SetWindowBordered :: proc(window: Window, bordered: b8) -> b8 ---
	SetWindowResizable :: proc(window: Window, resizable: b8) -> b8 ---
	SetWindowAlwaysOnTop :: proc(window: Window, on_top: b8) -> b8 ---
	ShowWindow :: proc(window: Window) -> b8 ---
	HideWindow :: proc(window: Window) -> b8 ---
	RaiseWindow :: proc(window: Window) -> b8 ---
	MaximizeWindow :: proc(window: Window) -> b8 ---
	MinimizeWindow :: proc(window: Window) -> b8 ---
	RestoreWindow :: proc(window: Window) -> b8 ---
	SetWindowFullscreen :: proc(window: Window, fullscreen: b8) -> b8 ---
	SyncWindow :: proc(window: Window) -> b8 ---
	WindowHasSurface :: proc(window: Window) -> b8 ---
	GetWindowSurface :: proc(window: Window) -> ^Surface ---
	SetWindowSurfaceVSync :: proc(window: Window, vsync: i32) -> b8 ---
	GetWindowSurfaceVSync :: proc(window: Window, vsync: ^i32) -> b8 ---
	UpdateWindowSurface :: proc(window: Window) -> b8 ---
	UpdateWindowSurfaceRects :: proc(window: Window, rects: [^]Rect, numrects: i32) -> b8 ---
	DestroyWindowSurface :: proc(window: Window) -> b8 ---
	SetWindowKeyboardGrab :: proc(window: Window, grabbed: b8) -> b8 ---
	SetWindowMouseGrab :: proc(window: Window, grabbed: b8) -> b8 ---
	GetWindowKeyboardGrab :: proc(window: Window) -> b8 ---
	GetWindowMouseGrab :: proc(window: Window) -> b8 ---
	GetGrabbedWindow :: proc() -> Window ---
	SetWindowMouseRect :: proc(window: Window, rect: ^Rect) -> b8 ---
	GetWindowMouseRect :: proc(window: Window) -> ^Rect ---
	SetWindowOpacity :: proc(window: Window, opacity: f32) -> b8 ---
	GetWindowOpacity :: proc(window: Window) -> f32 ---
	SetWindowParent :: proc(window: Window, parent: Window) -> b8 ---
	SetWindowModal :: proc(window: Window, modal: b8) -> b8 ---
	SetWindowFocusable :: proc(window: Window, focusable: b8) -> b8 ---
	ShowWindowSystemMenu :: proc(window: Window, x: i32, y: i32) -> b8 ---
	SetWindowHitTest :: proc(window: Window, callback: HitTest, callback_data: rawptr) -> b8 ---
	SetWindowShape :: proc(window: Window, shape: ^Surface) -> b8 ---
	FlashWindow :: proc(window: Window, operation: FlashOperation) -> b8 ---
	DestroyWindow :: proc(window: Window) ---
	ScreenSaverEnabled :: proc() -> b8 ---
	EnableScreenSaver :: proc() -> b8 ---
	DisableScreenSaver :: proc() -> b8 ---
	GL_LoadLibrary :: proc(path: cstring) -> b8 ---
	GL_GetProcAddress :: proc(proc_p: cstring) -> #type proc "c" () ---
	EGL_GetProcAddress :: proc(proc_p: cstring) -> #type proc "c" () ---
	GL_UnloadLibrary :: proc() ---
	GL_ExtensionSupported :: proc(extension: cstring) -> b8 ---
	GL_ResetAttributes :: proc() ---
	GL_SetAttribute :: proc(attr: GLAttr, value: i32) -> b8 ---
	GL_GetAttribute :: proc(attr: GLAttr, value: ^i32) -> b8 ---
	GL_CreateContext :: proc(window: Window) -> GLContext ---
	GL_MakeCurrent :: proc(window: Window, context_p: GLContext) -> b8 ---
	GL_GetCurrentWindow :: proc() -> Window ---
	GL_GetCurrentContext :: proc() -> GLContext ---
	EGL_GetCurrentDisplay :: proc() -> EGLDisplay ---
	EGL_GetCurrentConfig :: proc() -> EGLConfig ---
	EGL_GetWindowSurface :: proc(window: Window) -> EGLSurface ---
	EGL_SetAttributeCallbacks :: proc(platformAttribCallback: EGLAttribArrayCallback, surfaceAttribCallback: EGLIntArrayCallback, contextAttribCallback: EGLIntArrayCallback, userdata: rawptr) ---
	GL_SetSwapInterval :: proc(interval: i32) -> b8 ---
	GL_GetSwapInterval :: proc(interval: ^i32) -> b8 ---
	GL_SwapWindow :: proc(window: Window) -> b8 ---
	GL_DestroyContext :: proc(context_p: GLContext) -> b8 ---
	ShowOpenFileDialog :: proc(callback: DialogFileCallback, userdata: rawptr, window: Window, filters: [^]DialogFileFilter, nfilters: i32, default_location: cstring, allow_many: b8) ---
	ShowSaveFileDialog :: proc(callback: DialogFileCallback, userdata: rawptr, window: Window, filters: [^]DialogFileFilter, nfilters: i32, default_location: cstring) ---
	ShowOpenFolderDialog :: proc(callback: DialogFileCallback, userdata: rawptr, window: Window, default_location: cstring, allow_many: b8) ---
	GUIDToString :: proc(guid: GUID, pszGUID: cstring, cbGUID: i32) ---
	StringToGUID :: proc(pchGUID: cstring) -> GUID ---
	GetPowerInfo :: proc(seconds: [^]i32, percent: ^i32) -> PowerState ---
	GetSensors :: proc(count: ^i32) -> ^SensorID ---
	GetSensorNameForID :: proc(instance_id: SensorID) -> cstring ---
	GetSensorTypeForID :: proc(instance_id: SensorID) -> SensorType ---
	GetSensorNonPortableTypeForID :: proc(instance_id: SensorID) -> i32 ---
	OpenSensor :: proc(instance_id: SensorID) -> Sensor ---
	GetSensorFromID :: proc(instance_id: SensorID) -> Sensor ---
	GetSensorProperties :: proc(sensor: Sensor) -> PropertiesID ---
	GetSensorName :: proc(sensor: Sensor) -> cstring ---
	GetSensorType :: proc(sensor: Sensor) -> SensorType ---
	GetSensorNonPortableType :: proc(sensor: Sensor) -> i32 ---
	GetSensorID :: proc(sensor: Sensor) -> SensorID ---
	GetSensorData :: proc(sensor: Sensor, data: ^f32, num_values: i32) -> b8 ---
	CloseSensor :: proc(sensor: Sensor) ---
	UpdateSensors :: proc() ---
	LockJoysticks :: proc() ---
	UnlockJoysticks :: proc() ---
	HasJoystick :: proc() -> b8 ---
	GetJoysticks :: proc(count: ^i32) -> ^JoystickID ---
	GetJoystickNameForID :: proc(instance_id: JoystickID) -> cstring ---
	GetJoystickPathForID :: proc(instance_id: JoystickID) -> cstring ---
	GetJoystickPlayerIndexForID :: proc(instance_id: JoystickID) -> i32 ---
	GetJoystickGUIDForID :: proc(instance_id: JoystickID) -> GUID ---
	GetJoystickVendorForID :: proc(instance_id: JoystickID) -> u16 ---
	GetJoystickProductForID :: proc(instance_id: JoystickID) -> u16 ---
	GetJoystickProductVersionForID :: proc(instance_id: JoystickID) -> u16 ---
	GetJoystickTypeForID :: proc(instance_id: JoystickID) -> JoystickType ---
	OpenJoystick :: proc(instance_id: JoystickID) -> Joystick ---
	GetJoystickFromID :: proc(instance_id: JoystickID) -> Joystick ---
	GetJoystickFromPlayerIndex :: proc(player_index: i32) -> Joystick ---
	AttachVirtualJoystick :: proc(desc: ^VirtualJoystickDesc) -> JoystickID ---
	DetachVirtualJoystick :: proc(instance_id: JoystickID) -> b8 ---
	IsJoystickVirtual :: proc(instance_id: JoystickID) -> b8 ---
	SetJoystickVirtualAxis :: proc(joystick: Joystick, axis: i32, value: i16) -> b8 ---
	SetJoystickVirtualBall :: proc(joystick: Joystick, ball: i32, xrel: i16, yrel: i16) -> b8 ---
	SetJoystickVirtualButton :: proc(joystick: Joystick, button: i32, down: b8) -> b8 ---
	SetJoystickVirtualHat :: proc(joystick: Joystick, hat: i32, value: u8) -> b8 ---
	SetJoystickVirtualTouchpad :: proc(joystick: Joystick, touchpad: i32, finger: i32, down: b8, x: f32, y: f32, pressure: f32) -> b8 ---
	SendJoystickVirtualSensorData :: proc(joystick: Joystick, type: SensorType, sensor_timestamp: u64, data: ^f32, num_values: i32) -> b8 ---
	GetJoystickProperties :: proc(joystick: Joystick) -> PropertiesID ---
	GetJoystickName :: proc(joystick: Joystick) -> cstring ---
	GetJoystickPath :: proc(joystick: Joystick) -> cstring ---
	GetJoystickPlayerIndex :: proc(joystick: Joystick) -> i32 ---
	SetJoystickPlayerIndex :: proc(joystick: Joystick, player_index: i32) -> b8 ---
	GetJoystickGUID :: proc(joystick: Joystick) -> GUID ---
	GetJoystickVendor :: proc(joystick: Joystick) -> u16 ---
	GetJoystickProduct :: proc(joystick: Joystick) -> u16 ---
	GetJoystickProductVersion :: proc(joystick: Joystick) -> u16 ---
	GetJoystickFirmwareVersion :: proc(joystick: Joystick) -> u16 ---
	GetJoystickSerial :: proc(joystick: Joystick) -> cstring ---
	GetJoystickType :: proc(joystick: Joystick) -> JoystickType ---
	GetJoystickGUIDInfo :: proc(guid: GUID, vendor: ^u16, product: ^u16, version: ^u16, crc16: ^u16) ---
	JoystickConnected :: proc(joystick: Joystick) -> b8 ---
	GetJoystickID :: proc(joystick: Joystick) -> JoystickID ---
	GetNumJoystickAxes :: proc(joystick: Joystick) -> i32 ---
	GetNumJoystickBalls :: proc(joystick: Joystick) -> i32 ---
	GetNumJoystickHats :: proc(joystick: Joystick) -> i32 ---
	GetNumJoystickButtons :: proc(joystick: Joystick) -> i32 ---
	SetJoystickEventsEnabled :: proc(enabled: b8) ---
	JoystickEventsEnabled :: proc() -> b8 ---
	UpdateJoysticks :: proc() ---
	GetJoystickAxis :: proc(joystick: Joystick, axis: i32) -> i16 ---
	GetJoystickAxisInitialState :: proc(joystick: Joystick, axis: i32, state: ^i16) -> b8 ---
	GetJoystickBall :: proc(joystick: Joystick, ball: i32, dx: ^i32, dy: ^i32) -> b8 ---
	GetJoystickHat :: proc(joystick: Joystick, hat: i32) -> u8 ---
	GetJoystickButton :: proc(joystick: Joystick, button: i32) -> b8 ---
	RumbleJoystick :: proc(joystick: Joystick, low_frequency_rumble: u16, high_frequency_rumble: u16, duration_ms: u32) -> b8 ---
	RumbleJoystickTriggers :: proc(joystick: Joystick, left_rumble: u16, right_rumble: u16, duration_ms: u32) -> b8 ---
	SetJoystickLED :: proc(joystick: Joystick, red: u8, green: u8, blue: u8) -> b8 ---
	SendJoystickEffect :: proc(joystick: Joystick, data: rawptr, size: i32) -> b8 ---
	CloseJoystick :: proc(joystick: Joystick) ---
	GetJoystickConnectionState :: proc(joystick: Joystick) -> JoystickConnectionState ---
	GetJoystickPowerInfo :: proc(joystick: Joystick, percent: ^i32) -> PowerState ---
	AddGamepadMapping :: proc(mapping: cstring) -> i32 ---
	AddGamepadMappingsFromIO :: proc(src: IOStream, closeio: b8) -> i32 ---
	AddGamepadMappingsFromFile :: proc(file: cstring) -> i32 ---
	ReloadGamepadMappings :: proc() -> b8 ---
	GetGamepadMappings :: proc(count: ^i32) -> ^cstring ---
	GetGamepadMappingForGUID :: proc(guid: GUID) -> cstring ---
	GetGamepadMapping :: proc(gamepad: Gamepad) -> cstring ---
	SetGamepadMapping :: proc(instance_id: JoystickID, mapping: cstring) -> b8 ---
	HasGamepad :: proc() -> b8 ---
	GetGamepads :: proc(count: ^i32) -> ^JoystickID ---
	IsGamepad :: proc(instance_id: JoystickID) -> b8 ---
	GetGamepadNameForID :: proc(instance_id: JoystickID) -> cstring ---
	GetGamepadPathForID :: proc(instance_id: JoystickID) -> cstring ---
	GetGamepadPlayerIndexForID :: proc(instance_id: JoystickID) -> i32 ---
	GetGamepadGUIDForID :: proc(instance_id: JoystickID) -> GUID ---
	GetGamepadVendorForID :: proc(instance_id: JoystickID) -> u16 ---
	GetGamepadProductForID :: proc(instance_id: JoystickID) -> u16 ---
	GetGamepadProductVersionForID :: proc(instance_id: JoystickID) -> u16 ---
	GetGamepadTypeForID :: proc(instance_id: JoystickID) -> GamepadType ---
	GetRealGamepadTypeForID :: proc(instance_id: JoystickID) -> GamepadType ---
	GetGamepadMappingForID :: proc(instance_id: JoystickID) -> cstring ---
	OpenGamepad :: proc(instance_id: JoystickID) -> Gamepad ---
	GetGamepadFromID :: proc(instance_id: JoystickID) -> Gamepad ---
	GetGamepadFromPlayerIndex :: proc(player_index: i32) -> Gamepad ---
	GetGamepadProperties :: proc(gamepad: Gamepad) -> PropertiesID ---
	GetGamepadID :: proc(gamepad: Gamepad) -> JoystickID ---
	GetGamepadName :: proc(gamepad: Gamepad) -> cstring ---
	GetGamepadPath :: proc(gamepad: Gamepad) -> cstring ---
	GetGamepadType :: proc(gamepad: Gamepad) -> GamepadType ---
	GetRealGamepadType :: proc(gamepad: Gamepad) -> GamepadType ---
	GetGamepadPlayerIndex :: proc(gamepad: Gamepad) -> i32 ---
	SetGamepadPlayerIndex :: proc(gamepad: Gamepad, player_index: i32) -> b8 ---
	GetGamepadVendor :: proc(gamepad: Gamepad) -> u16 ---
	GetGamepadProduct :: proc(gamepad: Gamepad) -> u16 ---
	GetGamepadProductVersion :: proc(gamepad: Gamepad) -> u16 ---
	GetGamepadFirmwareVersion :: proc(gamepad: Gamepad) -> u16 ---
	GetGamepadSerial :: proc(gamepad: Gamepad) -> cstring ---
	GetGamepadSteamHandle :: proc(gamepad: Gamepad) -> u64 ---
	GetGamepadConnectionState :: proc(gamepad: Gamepad) -> JoystickConnectionState ---
	GetGamepadPowerInfo :: proc(gamepad: Gamepad, percent: ^i32) -> PowerState ---
	GamepadConnected :: proc(gamepad: Gamepad) -> b8 ---
	GetGamepadJoystick :: proc(gamepad: Gamepad) -> Joystick ---
	SetGamepadEventsEnabled :: proc(enabled: b8) ---
	GamepadEventsEnabled :: proc() -> b8 ---
	GetGamepadBindings :: proc(gamepad: Gamepad, count: ^i32) -> ^^GamepadBinding ---
	UpdateGamepads :: proc() ---
	GetGamepadTypeFromString :: proc(str: cstring) -> GamepadType ---
	GetGamepadStringForType :: proc(type: GamepadType) -> cstring ---
	GetGamepadAxisFromString :: proc(str: cstring) -> GamepadAxis ---
	GetGamepadStringForAxis :: proc(axis: GamepadAxis) -> cstring ---
	GamepadHasAxis :: proc(gamepad: Gamepad, axis: GamepadAxis) -> b8 ---
	GetGamepadAxis :: proc(gamepad: Gamepad, axis: GamepadAxis) -> i16 ---
	GetGamepadButtonFromString :: proc(str: cstring) -> GamepadButton ---
	GetGamepadStringForButton :: proc(button: GamepadButton) -> cstring ---
	GamepadHasButton :: proc(gamepad: Gamepad, button: GamepadButton) -> b8 ---
	GetGamepadButton :: proc(gamepad: Gamepad, button: GamepadButton) -> b8 ---
	GetGamepadButtonLabelForType :: proc(type: GamepadType, button: GamepadButton) -> GamepadButtonLabel ---
	GetGamepadButtonLabel :: proc(gamepad: Gamepad, button: GamepadButton) -> GamepadButtonLabel ---
	GetNumGamepadTouchpads :: proc(gamepad: Gamepad) -> i32 ---
	GetNumGamepadTouchpadFingers :: proc(gamepad: Gamepad, touchpad: i32) -> i32 ---
	GetGamepadTouchpadFinger :: proc(gamepad: Gamepad, touchpad: i32, finger: i32, down: ^b8, x: ^f32, y: ^f32, pressure: ^f32) -> b8 ---
	GamepadHasSensor :: proc(gamepad: Gamepad, type: SensorType) -> b8 ---
	SetGamepadSensorEnabled :: proc(gamepad: Gamepad, type: SensorType, enabled: b8) -> b8 ---
	GamepadSensorEnabled :: proc(gamepad: Gamepad, type: SensorType) -> b8 ---
	GetGamepadSensorDataRate :: proc(gamepad: Gamepad, type: SensorType) -> f32 ---
	GetGamepadSensorData :: proc(gamepad: Gamepad, type: SensorType, data: ^f32, num_values: i32) -> b8 ---
	RumbleGamepad :: proc(gamepad: Gamepad, low_frequency_rumble: u16, high_frequency_rumble: u16, duration_ms: u32) -> b8 ---
	RumbleGamepadTriggers :: proc(gamepad: Gamepad, left_rumble: u16, right_rumble: u16, duration_ms: u32) -> b8 ---
	SetGamepadLED :: proc(gamepad: Gamepad, red: u8, green: u8, blue: u8) -> b8 ---
	SendGamepadEffect :: proc(gamepad: Gamepad, data: rawptr, size: i32) -> b8 ---
	CloseGamepad :: proc(gamepad: Gamepad) ---
	GetGamepadAppleSFSymbolsNameForButton :: proc(gamepad: Gamepad, button: GamepadButton) -> cstring ---
	GetGamepadAppleSFSymbolsNameForAxis :: proc(gamepad: Gamepad, axis: GamepadAxis) -> cstring ---
	HasKeyboard :: proc() -> b8 ---
	GetKeyboards :: proc(count: ^i32) -> ^KeyboardID ---
	GetKeyboardNameForID :: proc(instance_id: KeyboardID) -> cstring ---
	GetKeyboardFocus :: proc() -> Window ---
	GetKeyboardState :: proc(numkeys: [^]i32) -> ^b8 ---
	ResetKeyboard :: proc() ---
	GetModState :: proc() -> Keymod ---
	SetModState :: proc(modstate: Keymod) ---
	GetKeyFromScancode :: proc(scancode: Scancode, modstate: Keymod, key_event: b8) -> Keycode ---
	GetScancodeFromKey :: proc(key: Keycode, modstate: ^Keymod) -> Scancode ---
	SetScancodeName :: proc(scancode: Scancode, name: cstring) -> b8 ---
	GetScancodeName :: proc(scancode: Scancode) -> cstring ---
	GetScancodeFromName :: proc(name: cstring) -> Scancode ---
	GetKeyName :: proc(key: Keycode) -> cstring ---
	GetKeyFromName :: proc(name: cstring) -> Keycode ---
	StartTextInput :: proc(window: Window) -> b8 ---
	StartTextInputWithProperties :: proc(window: Window, props: PropertiesID) -> b8 ---
	TextInputActive :: proc(window: Window) -> b8 ---
	StopTextInput :: proc(window: Window) -> b8 ---
	ClearComposition :: proc(window: Window) -> b8 ---
	SetTextInputArea :: proc(window: Window, rect: ^Rect, cursor: i32) -> b8 ---
	GetTextInputArea :: proc(window: Window, rect: ^Rect, cursor: ^i32) -> b8 ---
	HasScreenKeyboardSupport :: proc() -> b8 ---
	ScreenKeyboardShown :: proc(window: Window) -> b8 ---
	HasMouse :: proc() -> b8 ---
	GetMice :: proc(count: ^i32) -> ^MouseID ---
	GetMouseNameForID :: proc(instance_id: MouseID) -> cstring ---
	GetMouseFocus :: proc() -> Window ---
	GetMouseState :: proc(x: ^f32, y: ^f32) -> MouseButtonFlags ---
	GetGlobalMouseState :: proc(x: ^f32, y: ^f32) -> MouseButtonFlags ---
	GetRelativeMouseState :: proc(x: ^f32, y: ^f32) -> MouseButtonFlags ---
	WarpMouseInWindow :: proc(window: Window, x: f32, y: f32) ---
	WarpMouseGlobal :: proc(x: f32, y: f32) -> b8 ---
	SetWindowRelativeMouseMode :: proc(window: Window, enabled: b8) -> b8 ---
	GetWindowRelativeMouseMode :: proc(window: Window) -> b8 ---
	CaptureMouse :: proc(enabled: b8) -> b8 ---
	CreateCursor :: proc(data: ^u8, mask: ^u8, w: i32, h: i32, hot_x: i32, hot_y: i32) -> Cursor ---
	CreateColorCursor :: proc(surface: ^Surface, hot_x: i32, hot_y: i32) -> Cursor ---
	CreateSystemCursor :: proc(id: SystemCursor) -> Cursor ---
	SetCursor :: proc(cursor: Cursor) -> b8 ---
	GetCursor :: proc() -> Cursor ---
	GetDefaultCursor :: proc() -> Cursor ---
	DestroyCursor :: proc(cursor: Cursor) ---
	ShowCursor :: proc() -> b8 ---
	HideCursor :: proc() -> b8 ---
	CursorVisible :: proc() -> b8 ---
	GetTouchDevices :: proc(count: ^i32) -> ^TouchID ---
	GetTouchDeviceName :: proc(touchID: TouchID) -> cstring ---
	GetTouchDeviceType :: proc(touchID: TouchID) -> TouchDeviceType ---
	GetTouchFingers :: proc(touchID: TouchID, count: ^i32) -> ^^Finger ---
	PumpEvents :: proc() ---
	PeepEvents :: proc(events: [^]Event, numevents: i32, action: EventAction, minType: u32, maxType: u32) -> i32 ---
	HasEvent :: proc(type: u32) -> b8 ---
	HasEvents :: proc(minType: u32, maxType: u32) -> b8 ---
	FlushEvent :: proc(type: u32) ---
	FlushEvents :: proc(minType: u32, maxType: u32) ---
	PollEvent :: proc(event: ^Event) -> b8 ---
	WaitEvent :: proc(event: ^Event) -> b8 ---
	WaitEventTimeout :: proc(event: ^Event, timeoutMS: i32) -> b8 ---
	PushEvent :: proc(event: ^Event) -> b8 ---
	SetEventFilter :: proc(filter: EventFilter, userdata: rawptr) ---
	GetEventFilter :: proc(filter: ^EventFilter, userdata: ^rawptr) -> b8 ---
	AddEventWatch :: proc(filter: EventFilter, userdata: rawptr) -> b8 ---
	RemoveEventWatch :: proc(filter: EventFilter, userdata: rawptr) ---
	FilterEvents :: proc(filter: EventFilter, userdata: rawptr) ---
	SetEventEnabled :: proc(type: u32, enabled: b8) ---
	EventEnabled :: proc(type: u32) -> b8 ---
	RegisterEvents :: proc(numevents: i32) -> u32 ---
	GetWindowFromEvent :: proc(event: ^Event) -> Window ---
	GetBasePath :: proc() -> cstring ---
	GetPrefPath :: proc(org: cstring, app: cstring) -> cstring ---
	GetUserFolder :: proc(folder: Folder) -> cstring ---
	CreateDirectory :: proc(path: cstring) -> b8 ---
	EnumerateDirectory :: proc(path: cstring, callback: EnumerateDirectoryCallback, userdata: rawptr) -> b8 ---
	RemovePath :: proc(path: cstring) -> b8 ---
	RenamePath :: proc(oldpath: cstring, newpath: cstring) -> b8 ---
	CopyFile :: proc(oldpath: cstring, newpath: cstring) -> b8 ---
	GetPathInfo :: proc(path: cstring, info: ^PathInfo) -> b8 ---
	GlobDirectory :: proc(path: cstring, pattern: cstring, flags: GlobFlags, count: ^i32) -> ^cstring ---
	GPUSupportsShaderFormats :: proc(format_flags: GPUShaderFormat, name: cstring) -> b8 ---
	GPUSupportsProperties :: proc(props: PropertiesID) -> b8 ---
	CreateGPUDevice :: proc(format_flags: GPUShaderFormat, debug_mode: b8, name: cstring) -> GPUDevice ---
	CreateGPUDeviceWithProperties :: proc(props: PropertiesID) -> GPUDevice ---
	DestroyGPUDevice :: proc(device: GPUDevice) ---
	GetNumGPUDrivers :: proc() -> i32 ---
	GetGPUDriver :: proc(index: i32) -> cstring ---
	GetGPUDeviceDriver :: proc(device: GPUDevice) -> cstring ---
	GetGPUShaderFormats :: proc(device: GPUDevice) -> GPUShaderFormat ---
	CreateGPUComputePipeline :: proc(device: GPUDevice, createinfo: ^GPUComputePipelineCreateInfo) -> GPUComputePipeline ---
	CreateGPUGraphicsPipeline :: proc(device: GPUDevice, createinfo: ^GPUGraphicsPipelineCreateInfo) -> GPUGraphicsPipeline ---
	CreateGPUSampler :: proc(device: GPUDevice, createinfo: ^GPUSamplerCreateInfo) -> GPUSampler ---
	CreateGPUShader :: proc(device: GPUDevice, createinfo: ^GPUShaderCreateInfo) -> GPUShader ---
	CreateGPUTexture :: proc(device: GPUDevice, createinfo: ^GPUTextureCreateInfo) -> GPUTexture ---
	CreateGPUBuffer :: proc(device: GPUDevice, createinfo: ^GPUBufferCreateInfo) -> GPUBuffer ---
	CreateGPUTransferBuffer :: proc(device: GPUDevice, createinfo: ^GPUTransferBufferCreateInfo) -> GPUTransferBuffer ---
	SetGPUBufferName :: proc(device: GPUDevice, buffer: GPUBuffer, text: cstring) ---
	SetGPUTextureName :: proc(device: GPUDevice, texture: GPUTexture, text: cstring) ---
	InsertGPUDebugLabel :: proc(command_buffer: GPUCommandBuffer, text: cstring) ---
	PushGPUDebugGroup :: proc(command_buffer: GPUCommandBuffer, name: cstring) ---
	PopGPUDebugGroup :: proc(command_buffer: GPUCommandBuffer) ---
	ReleaseGPUTexture :: proc(device: GPUDevice, texture: GPUTexture) ---
	ReleaseGPUSampler :: proc(device: GPUDevice, sampler: GPUSampler) ---
	ReleaseGPUBuffer :: proc(device: GPUDevice, buffer: GPUBuffer) ---
	ReleaseGPUTransferBuffer :: proc(device: GPUDevice, transfer_buffer: GPUTransferBuffer) ---
	ReleaseGPUComputePipeline :: proc(device: GPUDevice, compute_pipeline: GPUComputePipeline) ---
	ReleaseGPUShader :: proc(device: GPUDevice, shader: GPUShader) ---
	ReleaseGPUGraphicsPipeline :: proc(device: GPUDevice, graphics_pipeline: GPUGraphicsPipeline) ---
	AcquireGPUCommandBuffer :: proc(device: GPUDevice) -> GPUCommandBuffer ---
	PushGPUVertexUniformData :: proc(command_buffer: GPUCommandBuffer, slot_index: u32, data: rawptr, length: u32) ---
	PushGPUFragmentUniformData :: proc(command_buffer: GPUCommandBuffer, slot_index: u32, data: rawptr, length: u32) ---
	PushGPUComputeUniformData :: proc(command_buffer: GPUCommandBuffer, slot_index: u32, data: rawptr, length: u32) ---
	BeginGPURenderPass :: proc(command_buffer: GPUCommandBuffer, color_target_infos: [^]GPUColorTargetInfo, num_color_targets: u32, depth_stencil_target_info: ^GPUDepthStencilTargetInfo) -> GPURenderPass ---
	BindGPUGraphicsPipeline :: proc(render_pass: [^]GPURenderPass, graphics_pipeline: GPUGraphicsPipeline) ---
	SetGPUViewport :: proc(render_pass: [^]GPURenderPass, viewport: ^GPUViewport) ---
	SetGPUScissor :: proc(render_pass: [^]GPURenderPass, scissor: ^Rect) ---
	SetGPUBlendConstants :: proc(render_pass: [^]GPURenderPass, blend_constants: FColor) ---
	SetGPUStencilReference :: proc(render_pass: [^]GPURenderPass, reference: u8) ---
	BindGPUVertexBuffers :: proc(render_pass: [^]GPURenderPass, first_slot: u32, bindings: [^]GPUBufferBinding, num_bindings: u32) ---
	BindGPUIndexBuffer :: proc(render_pass: [^]GPURenderPass, binding: ^GPUBufferBinding, index_element_size: GPUIndexElementSize) ---
	BindGPUVertexSamplers :: proc(render_pass: [^]GPURenderPass, first_slot: u32, texture_sampler_bindings: [^]GPUTextureSamplerBinding, num_bindings: u32) ---
	BindGPUVertexStorageTextures :: proc(render_pass: [^]GPURenderPass, first_slot: u32, storage_textures: ^[^]GPUTexture, num_bindings: u32) ---
	BindGPUVertexStorageBuffers :: proc(render_pass: [^]GPURenderPass, first_slot: u32, storage_buffers: ^[^]GPUBuffer, num_bindings: u32) ---
	BindGPUFragmentSamplers :: proc(render_pass: [^]GPURenderPass, first_slot: u32, texture_sampler_bindings: [^]GPUTextureSamplerBinding, num_bindings: u32) ---
	BindGPUFragmentStorageTextures :: proc(render_pass: [^]GPURenderPass, first_slot: u32, storage_textures: ^[^]GPUTexture, num_bindings: u32) ---
	BindGPUFragmentStorageBuffers :: proc(render_pass: [^]GPURenderPass, first_slot: u32, storage_buffers: ^[^]GPUBuffer, num_bindings: u32) ---
	DrawGPUIndexedPrimitives :: proc(render_pass: [^]GPURenderPass, num_indices: u32, num_instances: u32, first_index: u32, vertex_offset: i32, first_instance: u32) ---
	DrawGPUPrimitives :: proc(render_pass: [^]GPURenderPass, num_vertices: u32, num_instances: u32, first_vertex: u32, first_instance: u32) ---
	DrawGPUPrimitivesIndirect :: proc(render_pass: [^]GPURenderPass, buffer: GPUBuffer, offset: u32, draw_count: u32) ---
	DrawGPUIndexedPrimitivesIndirect :: proc(render_pass: [^]GPURenderPass, buffer: GPUBuffer, offset: u32, draw_count: u32) ---
	EndGPURenderPass :: proc(render_pass: [^]GPURenderPass) ---
	BeginGPUComputePass :: proc(command_buffer: GPUCommandBuffer, storage_texture_bindings: [^]GPUStorageTextureReadWriteBinding, num_storage_texture_bindings: u32, storage_buffer_bindings: [^]GPUStorageBufferReadWriteBinding, num_storage_buffer_bindings: u32) -> GPUComputePass ---
	BindGPUComputePipeline :: proc(compute_pass: [^]GPUComputePass, compute_pipeline: GPUComputePipeline) ---
	BindGPUComputeSamplers :: proc(compute_pass: [^]GPUComputePass, first_slot: u32, texture_sampler_bindings: [^]GPUTextureSamplerBinding, num_bindings: u32) ---
	BindGPUComputeStorageTextures :: proc(compute_pass: [^]GPUComputePass, first_slot: u32, storage_textures: ^[^]GPUTexture, num_bindings: u32) ---
	BindGPUComputeStorageBuffers :: proc(compute_pass: [^]GPUComputePass, first_slot: u32, storage_buffers: ^[^]GPUBuffer, num_bindings: u32) ---
	DispatchGPUCompute :: proc(compute_pass: [^]GPUComputePass, groupcount_x: u32, groupcount_y: u32, groupcount_z: u32) ---
	DispatchGPUComputeIndirect :: proc(compute_pass: [^]GPUComputePass, buffer: GPUBuffer, offset: u32) ---
	EndGPUComputePass :: proc(compute_pass: [^]GPUComputePass) ---
	MapGPUTransferBuffer :: proc(device: GPUDevice, transfer_buffer: GPUTransferBuffer, cycle: b8) -> rawptr ---
	UnmapGPUTransferBuffer :: proc(device: GPUDevice, transfer_buffer: GPUTransferBuffer) ---
	BeginGPUCopyPass :: proc(command_buffer: GPUCommandBuffer) -> GPUCopyPass ---
	UploadToGPUTexture :: proc(copy_pass: [^]GPUCopyPass, source: ^GPUTextureTransferInfo, destination: ^GPUTextureRegion, cycle: b8) ---
	UploadToGPUBuffer :: proc(copy_pass: [^]GPUCopyPass, source: ^GPUTransferBufferLocation, destination: ^GPUBufferRegion, cycle: b8) ---
	CopyGPUTextureToTexture :: proc(copy_pass: [^]GPUCopyPass, source: ^GPUTextureLocation, destination: ^GPUTextureLocation, w: u32, h: u32, d: u32, cycle: b8) ---
	CopyGPUBufferToBuffer :: proc(copy_pass: [^]GPUCopyPass, source: ^GPUBufferLocation, destination: ^GPUBufferLocation, size: u32, cycle: b8) ---
	DownloadFromGPUTexture :: proc(copy_pass: [^]GPUCopyPass, source: ^GPUTextureRegion, destination: ^GPUTextureTransferInfo) ---
	DownloadFromGPUBuffer :: proc(copy_pass: [^]GPUCopyPass, source: ^GPUBufferRegion, destination: ^GPUTransferBufferLocation) ---
	EndGPUCopyPass :: proc(copy_pass: [^]GPUCopyPass) ---
	GenerateMipmapsForGPUTexture :: proc(command_buffer: GPUCommandBuffer, texture: GPUTexture) ---
	BlitGPUTexture :: proc(command_buffer: GPUCommandBuffer, info: ^GPUBlitInfo) ---
	WindowSupportsGPUSwapchainComposition :: proc(device: GPUDevice, window: Window, swapchain_composition: GPUSwapchainComposition) -> b8 ---
	WindowSupportsGPUPresentMode :: proc(device: GPUDevice, window: Window, present_mode: GPUPresentMode) -> b8 ---
	ClaimWindowForGPUDevice :: proc(device: GPUDevice, window: Window) -> b8 ---
	ReleaseWindowFromGPUDevice :: proc(device: GPUDevice, window: Window) ---
	SetGPUSwapchainParameters :: proc(device: GPUDevice, window: Window, swapchain_composition: GPUSwapchainComposition, present_mode: GPUPresentMode) -> b8 ---
	GetGPUSwapchainTextureFormat :: proc(device: GPUDevice, window: Window) -> GPUTextureFormat ---
	AcquireGPUSwapchainTexture :: proc(command_buffer: GPUCommandBuffer, window: Window, swapchain_texture: ^^GPUTexture, swapchain_texture_width: ^u32, swapchain_texture_height: ^u32) -> b8 ---
	SubmitGPUCommandBuffer :: proc(command_buffer: GPUCommandBuffer) -> b8 ---
	SubmitGPUCommandBufferAndAcquireFence :: proc(command_buffer: GPUCommandBuffer) -> GPUFence ---
	CancelGPUCommandBuffer :: proc(command_buffer: GPUCommandBuffer) -> b8 ---
	WaitForGPUIdle :: proc(device: GPUDevice) -> b8 ---
	WaitForGPUFences :: proc(device: GPUDevice, wait_all: b8, fences: ^[^]GPUFence, num_fences: u32) -> b8 ---
	QueryGPUFence :: proc(device: GPUDevice, fence: GPUFence) -> b8 ---
	ReleaseGPUFence :: proc(device: GPUDevice, fence: GPUFence) ---
	GPUTextureFormatTexelBlockSize :: proc(format: GPUTextureFormat) -> u32 ---
	GPUTextureSupportsFormat :: proc(device: GPUDevice, format: GPUTextureFormat, type: GPUTextureType, usage: GPUTextureUsageFlags) -> b8 ---
	GPUTextureSupportsSampleCount :: proc(device: GPUDevice, format: GPUTextureFormat, sample_count: GPUSampleCount) -> b8 ---
	CalculateGPUTextureFormatSize :: proc(format: GPUTextureFormat, width: u32, height: u32, depth_or_layer_count: u32) -> u32 ---
	GetHaptics :: proc(count: ^i32) -> ^HapticID ---
	GetHapticNameForID :: proc(instance_id: HapticID) -> cstring ---
	OpenHaptic :: proc(instance_id: HapticID) -> Haptic ---
	GetHapticFromID :: proc(instance_id: HapticID) -> Haptic ---
	GetHapticID :: proc(haptic: Haptic) -> HapticID ---
	GetHapticName :: proc(haptic: Haptic) -> cstring ---
	IsMouseHaptic :: proc() -> b8 ---
	OpenHapticFromMouse :: proc() -> Haptic ---
	IsJoystickHaptic :: proc(joystick: Joystick) -> b8 ---
	OpenHapticFromJoystick :: proc(joystick: Joystick) -> Haptic ---
	CloseHaptic :: proc(haptic: Haptic) ---
	GetMaxHapticEffects :: proc(haptic: Haptic) -> i32 ---
	GetMaxHapticEffectsPlaying :: proc(haptic: Haptic) -> i32 ---
	GetHapticFeatures :: proc(haptic: Haptic) -> u32 ---
	GetNumHapticAxes :: proc(haptic: Haptic) -> i32 ---
	HapticEffectSupported :: proc(haptic: Haptic, effect: ^HapticEffect) -> b8 ---
	CreateHapticEffect :: proc(haptic: Haptic, effect: ^HapticEffect) -> i32 ---
	UpdateHapticEffect :: proc(haptic: Haptic, effect: i32, data: ^HapticEffect) -> b8 ---
	RunHapticEffect :: proc(haptic: Haptic, effect: i32, iterations: u32) -> b8 ---
	StopHapticEffect :: proc(haptic: Haptic, effect: i32) -> b8 ---
	DestroyHapticEffect :: proc(haptic: Haptic, effect: i32) ---
	GetHapticEffectStatus :: proc(haptic: Haptic, effect: i32) -> b8 ---
	SetHapticGain :: proc(haptic: Haptic, gain: i32) -> b8 ---
	SetHapticAutocenter :: proc(haptic: Haptic, autocenter: i32) -> b8 ---
	PauseHaptic :: proc(haptic: Haptic) -> b8 ---
	ResumeHaptic :: proc(haptic: Haptic) -> b8 ---
	StopHapticEffects :: proc(haptic: Haptic) -> b8 ---
	HapticRumbleSupported :: proc(haptic: Haptic) -> b8 ---
	InitHapticRumble :: proc(haptic: Haptic) -> b8 ---
	PlayHapticRumble :: proc(haptic: Haptic, strength: f32, length: u32) -> b8 ---
	StopHapticRumble :: proc(haptic: Haptic) -> b8 ---
	hid_init :: proc() -> i32 ---
	hid_exit :: proc() -> i32 ---
	hid_device_change_count :: proc() -> u32 ---
	hid_enumerate :: proc(vendor_id: u16, product_id: u16) -> ^hid_device_info ---
	hid_free_enumeration :: proc(devs: [^]hid_device_info) ---
	hid_open :: proc(vendor_id: u16, product_id: u16, serial_number: ^i32) -> hid_device ---
	hid_open_path :: proc(path: cstring) -> hid_device ---
	hid_write :: proc(dev: hid_device, data: ^u8, length: u64) -> i32 ---
	hid_read_timeout :: proc(dev: hid_device, data: ^u8, length: u64, milliseconds: i32) -> i32 ---
	hid_read :: proc(dev: hid_device, data: ^u8, length: u64) -> i32 ---
	hid_set_nonblocking :: proc(dev: hid_device, nonblock: i32) -> i32 ---
	hid_send_feature_report :: proc(dev: hid_device, data: ^u8, length: u64) -> i32 ---
	hid_get_feature_report :: proc(dev: hid_device, data: ^u8, length: u64) -> i32 ---
	hid_get_input_report :: proc(dev: hid_device, data: ^u8, length: u64) -> i32 ---
	hid_close :: proc(dev: hid_device) -> i32 ---
	hid_get_manufacturer_string :: proc(dev: hid_device, string_p: ^i32, maxlen: u64) -> i32 ---
	hid_get_product_string :: proc(dev: hid_device, string_p: ^i32, maxlen: u64) -> i32 ---
	hid_get_serial_number_string :: proc(dev: hid_device, string_p: ^i32, maxlen: u64) -> i32 ---
	hid_get_indexed_string :: proc(dev: hid_device, string_index: i32, string_p: ^i32, maxlen: u64) -> i32 ---
	hid_get_device_info :: proc(dev: hid_device) -> ^hid_device_info ---
	hid_get_report_descriptor :: proc(dev: hid_device, buf: ^u8, buf_size: u64) -> i32 ---
	hid_ble_scan :: proc(active: b8) ---
	SetHintWithPriority :: proc(name: cstring, value: cstring, priority: HintPriority) -> b8 ---
	SetHint :: proc(name: cstring, value: cstring) -> b8 ---
	ResetHint :: proc(name: cstring) -> b8 ---
	ResetHints :: proc() ---
	GetHint :: proc(name: cstring) -> cstring ---
	GetHintBoolean :: proc(name: cstring, default_value: b8) -> b8 ---
	AddHintCallback :: proc(name: cstring, callback: HintCallback, userdata: rawptr) -> b8 ---
	RemoveHintCallback :: proc(name: cstring, callback: HintCallback, userdata: rawptr) ---
	Init :: proc(flags: InitFlags) -> b8 ---
	InitSubSystem :: proc(flags: InitFlags) -> b8 ---
	QuitSubSystem :: proc(flags: InitFlags) ---
	WasInit :: proc(flags: InitFlags) -> InitFlags ---
	Quit :: proc() ---
	SetAppMetadata :: proc(appname: cstring, appversion: cstring, appidentifier: cstring) -> b8 ---
	SetAppMetadataProperty :: proc(name: cstring, value: cstring) -> b8 ---
	GetAppMetadataProperty :: proc(name: cstring) -> cstring ---
	LoadObject :: proc(sofile: cstring) -> SharedObject ---
	LoadFunction :: proc(handle: SharedObject, name: cstring) -> #type proc "c" () ---
	UnloadObject :: proc(handle: SharedObject) ---
	GetPreferredLocales :: proc(count: ^i32) -> ^^Locale ---
	SetLogPriorities :: proc(priority: LogPriority) ---
	SetLogPriority :: proc(category: i32, priority: LogPriority) ---
	GetLogPriority :: proc(category: i32) -> LogPriority ---
	ResetLogPriorities :: proc() ---
	SetLogPriorityPrefix :: proc(priority: LogPriority, prefix: cstring) -> b8 ---
	Log :: proc(fmt: cstring, #c_vararg var_args: ..any) ---
	LogTrace :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogVerbose :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogDebug :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogInfo :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogWarn :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogError :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogCritical :: proc(category: i32, fmt: cstring, #c_vararg var_args: ..any) ---
	LogMessage :: proc(category: i32, priority: LogPriority, fmt: cstring, #c_vararg var_args: ..any) ---
	LogMessageV :: proc(category: i32, priority: LogPriority, fmt: cstring, #c_vararg var_args: ..any) ---
	GetDefaultLogOutputFunction :: proc() -> LogOutputFunction ---
	GetLogOutputFunction :: proc(callback: ^LogOutputFunction, userdata: ^rawptr) ---
	SetLogOutputFunction :: proc(callback: LogOutputFunction, userdata: rawptr) ---
	ShowMessageBox :: proc(messageboxdata: ^MessageBoxData, buttonid: ^i32) -> b8 ---
	ShowSimpleMessageBox :: proc(flags: MessageBoxFlags, title: cstring, message: cstring, window: Window) -> b8 ---
	Metal_CreateView :: proc(window: Window) -> MetalView ---
	Metal_DestroyView :: proc(view: MetalView) ---
	Metal_GetLayer :: proc(view: MetalView) -> rawptr ---
	OpenURL :: proc(url: cstring) -> b8 ---
	GetPlatform :: proc() -> cstring ---
	CreateProcess :: proc(args: [^]cstring, pipe_stdio: b8) -> Process ---
	CreateProcessWithProperties :: proc(props: PropertiesID) -> Process ---
	GetProcessProperties :: proc(process: [^]Process) -> PropertiesID ---
	ReadProcess :: proc(process: [^]Process, datasize: ^u64, exitcode: ^i32) -> rawptr ---
	GetProcessInput :: proc(process: [^]Process) -> IOStream ---
	GetProcessOutput :: proc(process: [^]Process) -> IOStream ---
	KillProcess :: proc(process: [^]Process, force: b8) -> b8 ---
	WaitProcess :: proc(process: [^]Process, block: b8, exitcode: ^i32) -> b8 ---
	DestroyProcess :: proc(process: [^]Process) ---
	GetNumRenderDrivers :: proc() -> i32 ---
	GetRenderDriver :: proc(index: i32) -> cstring ---
	CreateWindowAndRenderer :: proc(title: cstring, width: i32, height: i32, window_flags: WindowFlags, window: ^Window, renderer: ^^Renderer) -> b8 ---
	CreateRenderer :: proc(window: Window, name: cstring) -> Renderer ---
	CreateRendererWithProperties :: proc(props: PropertiesID) -> Renderer ---
	CreateSoftwareRenderer :: proc(surface: ^Surface) -> Renderer ---
	GetRenderer :: proc(window: Window) -> Renderer ---
	GetRenderWindow :: proc(renderer: Renderer) -> Window ---
	GetRendererName :: proc(renderer: Renderer) -> cstring ---
	GetRendererProperties :: proc(renderer: Renderer) -> PropertiesID ---
	GetRenderOutputSize :: proc(renderer: Renderer, w: ^i32, h: ^i32) -> b8 ---
	GetCurrentRenderOutputSize :: proc(renderer: Renderer, w: ^i32, h: ^i32) -> b8 ---
	CreateTexture :: proc(renderer: Renderer, format: PixelFormat, access: TextureAccess, w: i32, h: i32) -> ^Texture ---
	CreateTextureFromSurface :: proc(renderer: Renderer, surface: ^Surface) -> ^Texture ---
	CreateTextureWithProperties :: proc(renderer: Renderer, props: PropertiesID) -> ^Texture ---
	GetTextureProperties :: proc(texture: ^Texture) -> PropertiesID ---
	GetRendererFromTexture :: proc(texture: ^Texture) -> Renderer ---
	GetTextureSize :: proc(texture: ^Texture, w: ^f32, h: ^f32) -> b8 ---
	SetTextureColorMod :: proc(texture: ^Texture, r: u8, g: u8, b: u8) -> b8 ---
	SetTextureColorModFloat :: proc(texture: ^Texture, r: f32, g: f32, b: f32) -> b8 ---
	GetTextureColorMod :: proc(texture: ^Texture, r: ^u8, g: ^u8, b: ^u8) -> b8 ---
	GetTextureColorModFloat :: proc(texture: ^Texture, r: ^f32, g: ^f32, b: ^f32) -> b8 ---
	SetTextureAlphaMod :: proc(texture: ^Texture, alpha: u8) -> b8 ---
	SetTextureAlphaModFloat :: proc(texture: ^Texture, alpha: f32) -> b8 ---
	GetTextureAlphaMod :: proc(texture: ^Texture, alpha: ^u8) -> b8 ---
	GetTextureAlphaModFloat :: proc(texture: ^Texture, alpha: ^f32) -> b8 ---
	SetTextureBlendMode :: proc(texture: ^Texture, blendMode: BlendMode) -> b8 ---
	GetTextureBlendMode :: proc(texture: ^Texture, blendMode: ^BlendMode) -> b8 ---
	SetTextureScaleMode :: proc(texture: ^Texture, scaleMode: ScaleMode) -> b8 ---
	GetTextureScaleMode :: proc(texture: ^Texture, scaleMode: ^ScaleMode) -> b8 ---
	UpdateTexture :: proc(texture: ^Texture, rect: ^Rect, pixels: rawptr, pitch: i32) -> b8 ---
	UpdateYUVTexture :: proc(texture: ^Texture, rect: ^Rect, Yplane: ^u8, Ypitch: i32, Uplane: ^u8, Upitch: i32, Vplane: ^u8, Vpitch: i32) -> b8 ---
	UpdateNVTexture :: proc(texture: ^Texture, rect: ^Rect, Yplane: ^u8, Ypitch: i32, UVplane: ^u8, UVpitch: i32) -> b8 ---
	LockTexture :: proc(texture: ^Texture, rect: ^Rect, pixels: [^]rawptr, pitch: ^i32) -> b8 ---
	LockTextureToSurface :: proc(texture: ^Texture, rect: ^Rect, surface: ^^Surface) -> b8 ---
	UnlockTexture :: proc(texture: ^Texture) ---
	SetRenderTarget :: proc(renderer: Renderer, texture: ^Texture) -> b8 ---
	GetRenderTarget :: proc(renderer: Renderer) -> ^Texture ---
	SetRenderLogicalPresentation :: proc(renderer: Renderer, w: i32, h: i32, mode: RendererLogicalPresentation) -> b8 ---
	GetRenderLogicalPresentation :: proc(renderer: Renderer, w: ^i32, h: ^i32, mode: ^RendererLogicalPresentation) -> b8 ---
	GetRenderLogicalPresentationRect :: proc(renderer: Renderer, rect: ^FRect) -> b8 ---
	RenderCoordinatesFromWindow :: proc(renderer: Renderer, window_x: f32, window_y: f32, x: ^f32, y: ^f32) -> b8 ---
	RenderCoordinatesToWindow :: proc(renderer: Renderer, x: f32, y: f32, window_x: ^f32, window_y: ^f32) -> b8 ---
	ConvertEventToRenderCoordinates :: proc(renderer: Renderer, event: ^Event) -> b8 ---
	SetRenderViewport :: proc(renderer: Renderer, rect: ^Rect) -> b8 ---
	GetRenderViewport :: proc(renderer: Renderer, rect: ^Rect) -> b8 ---
	RenderViewportSet :: proc(renderer: Renderer) -> b8 ---
	GetRenderSafeArea :: proc(renderer: Renderer, rect: ^Rect) -> b8 ---
	SetRenderClipRect :: proc(renderer: Renderer, rect: ^Rect) -> b8 ---
	GetRenderClipRect :: proc(renderer: Renderer, rect: ^Rect) -> b8 ---
	RenderClipEnabled :: proc(renderer: Renderer) -> b8 ---
	SetRenderScale :: proc(renderer: Renderer, scaleX: f32, scaleY: f32) -> b8 ---
	GetRenderScale :: proc(renderer: Renderer, scaleX: ^f32, scaleY: ^f32) -> b8 ---
	SetRenderDrawColor :: proc(renderer: Renderer, r: u8, g: u8, b: u8, a: u8) -> b8 ---
	SetRenderDrawColorFloat :: proc(renderer: Renderer, r: f32, g: f32, b: f32, a: f32) -> b8 ---
	GetRenderDrawColor :: proc(renderer: Renderer, r: ^u8, g: ^u8, b: ^u8, a: ^u8) -> b8 ---
	GetRenderDrawColorFloat :: proc(renderer: Renderer, r: ^f32, g: ^f32, b: ^f32, a: ^f32) -> b8 ---
	SetRenderColorScale :: proc(renderer: Renderer, scale: f32) -> b8 ---
	GetRenderColorScale :: proc(renderer: Renderer, scale: ^f32) -> b8 ---
	SetRenderDrawBlendMode :: proc(renderer: Renderer, blendMode: BlendMode) -> b8 ---
	GetRenderDrawBlendMode :: proc(renderer: Renderer, blendMode: ^BlendMode) -> b8 ---
	RenderClear :: proc(renderer: Renderer) -> b8 ---
	RenderPoint :: proc(renderer: Renderer, x: f32, y: f32) -> b8 ---
	RenderPoints :: proc(renderer: Renderer, points: [^]FPoint, count: i32) -> b8 ---
	RenderLine :: proc(renderer: Renderer, x1: f32, y1: f32, x2: f32, y2: f32) -> b8 ---
	RenderLines :: proc(renderer: Renderer, points: [^]FPoint, count: i32) -> b8 ---
	RenderRect :: proc(renderer: Renderer, rect: ^FRect) -> b8 ---
	RenderRects :: proc(renderer: Renderer, rects: [^]FRect, count: i32) -> b8 ---
	RenderFillRect :: proc(renderer: Renderer, rect: ^FRect) -> b8 ---
	RenderFillRects :: proc(renderer: Renderer, rects: [^]FRect, count: i32) -> b8 ---
	RenderTexture :: proc(renderer: Renderer, texture: ^Texture, srcrect: ^FRect, dstrect: ^FRect) -> b8 ---
	RenderTextureRotated :: proc(renderer: Renderer, texture: ^Texture, srcrect: ^FRect, dstrect: ^FRect, angle: f64, center: ^FPoint, flip: FlipMode) -> b8 ---
	RenderTextureTiled :: proc(renderer: Renderer, texture: ^Texture, srcrect: ^FRect, scale: f32, dstrect: ^FRect) -> b8 ---
	RenderTexture9Grid :: proc(renderer: Renderer, texture: ^Texture, srcrect: ^FRect, left_width: f32, right_width: f32, top_height: f32, bottom_height: f32, scale: f32, dstrect: ^FRect) -> b8 ---
	RenderGeometry :: proc(renderer: Renderer, texture: ^Texture, vertices: [^]Vertex, num_vertices: i32, indices: [^]i32, num_indices: i32) -> b8 ---
	RenderGeometryRaw :: proc(renderer: Renderer, texture: ^Texture, xy: ^f32, xy_stride: i32, color: ^FColor, color_stride: i32, uv: ^f32, uv_stride: i32, num_vertices: i32, indices: rawptr, num_indices: i32, size_indices: i32) -> b8 ---
	RenderReadPixels :: proc(renderer: Renderer, rect: ^Rect) -> ^Surface ---
	RenderPresent :: proc(renderer: Renderer) -> b8 ---
	DestroyTexture :: proc(texture: ^Texture) ---
	DestroyRenderer :: proc(renderer: Renderer) ---
	FlushRenderer :: proc(renderer: Renderer) -> b8 ---
	GetRenderMetalLayer :: proc(renderer: Renderer) -> rawptr ---
	GetRenderMetalCommandEncoder :: proc(renderer: Renderer) -> rawptr ---
	AddVulkanRenderSemaphores :: proc(renderer: Renderer, wait_stage_mask: u32, wait_semaphore: i64, signal_semaphore: i64) -> b8 ---
	SetRenderVSync :: proc(renderer: Renderer, vsync: i32) -> b8 ---
	GetRenderVSync :: proc(renderer: Renderer, vsync: ^i32) -> b8 ---
	RenderDebugText :: proc(renderer: Renderer, x: f32, y: f32, str: cstring) -> b8 ---
	OpenTitleStorage :: proc(override: cstring, props: PropertiesID) -> Storage ---
	OpenUserStorage :: proc(org: cstring, app: cstring, props: PropertiesID) -> Storage ---
	OpenFileStorage :: proc(path: cstring) -> Storage ---
	OpenStorage :: proc(iface: ^StorageInterface, userdata: rawptr) -> Storage ---
	CloseStorage :: proc(storage: Storage) -> b8 ---
	StorageReady :: proc(storage: Storage) -> b8 ---
	GetStorageFileSize :: proc(storage: Storage, path: cstring, length: ^u64) -> b8 ---
	ReadStorageFile :: proc(storage: Storage, path: cstring, destination: rawptr, length: u64) -> b8 ---
	WriteStorageFile :: proc(storage: Storage, path: cstring, source: rawptr, length: u64) -> b8 ---
	CreateStorageDirectory :: proc(storage: Storage, path: cstring) -> b8 ---
	EnumerateStorageDirectory :: proc(storage: Storage, path: cstring, callback: EnumerateDirectoryCallback, userdata: rawptr) -> b8 ---
	RemoveStoragePath :: proc(storage: Storage, path: cstring) -> b8 ---
	RenameStoragePath :: proc(storage: Storage, oldpath: cstring, newpath: cstring) -> b8 ---
	CopyStorageFile :: proc(storage: Storage, oldpath: cstring, newpath: cstring) -> b8 ---
	GetStoragePathInfo :: proc(storage: Storage, path: cstring, info: ^PathInfo) -> b8 ---
	GetStorageSpaceRemaining :: proc(storage: Storage) -> u64 ---
	GlobStorageDirectory :: proc(storage: Storage, path: cstring, pattern: cstring, flags: GlobFlags, count: ^i32) -> ^cstring ---
	SetX11EventHook :: proc(callback: X11EventHook, userdata: rawptr) ---
	SetLinuxThreadPriority :: proc(threadID: i64, priority: i32) -> b8 ---
	SetLinuxThreadPriorityAndPolicy :: proc(threadID: i64, sdlPriority: i32, schedPolicy: i32) -> b8 ---
	IsTablet :: proc() -> b8 ---
	IsTV :: proc() -> b8 ---
	GetSandbox :: proc() -> Sandbox ---
	OnApplicationWillTerminate :: proc() ---
	OnApplicationDidReceiveMemoryWarning :: proc() ---
	OnApplicationWillEnterBackground :: proc() ---
	OnApplicationDidEnterBackground :: proc() ---
	OnApplicationWillEnterForeground :: proc() ---
	OnApplicationDidEnterForeground :: proc() ---
	GetDateTimeLocalePreferences :: proc(dateFormat: ^DateFormat, timeFormat: ^TimeFormat) -> b8 ---
	GetCurrentTime :: proc(ticks: [^]i64) -> b8 ---
	TimeToDateTime :: proc(ticks: i64, dt: ^DateTime, localTime: b8) -> b8 ---
	DateTimeToTime :: proc(dt: ^DateTime, ticks: [^]i64) -> b8 ---
	TimeToWindows :: proc(ticks: i64, dwLowDateTime: ^u32, dwHighDateTime: ^u32) ---
	TimeFromWindows :: proc(dwLowDateTime: u32, dwHighDateTime: u32) -> i64 ---
	GetDaysInMonth :: proc(year: i32, month: i32) -> i32 ---
	GetDayOfYear :: proc(year: i32, month: i32, day: i32) -> i32 ---
	GetDayOfWeek :: proc(year: i32, month: i32, day: i32) -> i32 ---
	GetTicks :: proc() -> u64 ---
	GetTicksNS :: proc() -> u64 ---
	GetPerformanceCounter :: proc() -> u64 ---
	GetPerformanceFrequency :: proc() -> u64 ---
	Delay :: proc(ms: u32) ---
	DelayNS :: proc(ns: u64) ---
	DelayPrecise :: proc(ns: u64) ---
	AddTimer :: proc(interval: u32, callback: TimerCallback, userdata: rawptr) -> TimerID ---
	AddTimerNS :: proc(interval: u64, callback: NSTimerCallback, userdata: rawptr) -> TimerID ---
	RemoveTimer :: proc(id: TimerID) -> b8 ---
	GetVersion :: proc() -> i32 ---
	GetRevision :: proc() -> cstring ---

}
