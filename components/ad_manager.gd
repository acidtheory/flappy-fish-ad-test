extends Node
class_name AdManager

const AD_ID_BANNER = "ca-app-pub-9036926653791319/6642507886"
const AD_ID_REWARD = "ca-app-pub-9036926653791319/6748251419"

var ads_initialized : bool = false

func _ready() -> void:
	var listener := OnInitializationCompleteListener.new()
	listener.on_initialization_complete = _on_ads_initialize
	MobileAds.initialize(listener)

func _on_ads_initialize(_parametro_inutil):
	print("Ads initialized!")
	ads_initialized = true

var ad_view_banner : AdView
func create_banner_ad(ad_position : AdPosition):
	while not ads_initialized:
		print("Awaiting ads initialization...")
		await get_tree().create_timer(1).timeout
	if ad_view_banner: ad_view_banner.destroy()
	# si hay un banner ya, borrarlo
	
	ad_view_banner = AdView.new(AD_ID_BANNER,AdSize.BANNER,ad_position)
	# crear un adview con los settings del banner
	
	var _ad_listener = AdListener.new()
	_ad_listener.on_ad_clicked = func(): print("ad clicked")
	_ad_listener.on_ad_closed = func(): print("ad closed")
	_ad_listener.on_ad_failed_to_load = func(): print("ad failed to load")
	_ad_listener.on_ad_impression = func(): print("ad impression")
	_ad_listener.on_ad_loaded = func(): print("ad loaded")
	_ad_listener.on_ad_opened = func(): print("ad opened")
	ad_view_banner.ad_listener = _ad_listener
	# hacer debugging del ad
	
	var ad_request = AdRequest.new()
	ad_view_banner.load_ad(ad_request)
	# cargar el ad

signal on_ad_reward_gained
var ad_view_reward
func create_reward_ad():
	while not ads_initialized:
		print("Awaiting ads initialization...")
		await get_tree().create_timer(1).timeout
	if ad_view_reward: ad_view_reward.destroy()
	
	var rewarded_ad_load_callback := RewardedAdLoadCallback.new()
	rewarded_ad_load_callback.on_ad_loaded = _on_rewarded_ad_loaded
	RewardedAdLoader.new().load(AD_ID_REWARD, AdRequest.new(), rewarded_ad_load_callback)
	
	var _ad_listener = AdListener.new()
	_ad_listener.on_ad_clicked = func(): print("ad clicked")
	_ad_listener.on_ad_closed = func(): print("ad closed")
	_ad_listener.on_ad_failed_to_load = func(): print("ad failed to load")
	_ad_listener.on_ad_impression = func(): print("ad impression")
	_ad_listener.on_ad_loaded = func(): print("ad loaded")
	_ad_listener.on_ad_opened = func(): print("ad opened")
	ad_view_banner.ad_listener = _ad_listener
	
	await on_ad_reward_gained
	

func _on_rewarded_ad_loaded(new_rewarded_ad : RewardedAd):
	ad_view_reward = new_rewarded_ad
	var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()
	on_user_earned_reward_listener.on_user_earned_reward = func(_reward): on_ad_reward_gained.emit()
	new_rewarded_ad.show(on_user_earned_reward_listener)
