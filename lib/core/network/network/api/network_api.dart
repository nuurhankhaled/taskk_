class Api {
  //base Url

  // /// Debug
  static const String debugIpAddress = "45.241.5.246";
  static const String socketUrl = "http://$debugIpAddress:3334/";
  static const String mainAppUrl = "http://$debugIpAddress:3333/";

  // // Production
  // static const String productionIpAddress = "vibezo.org";
  // static const String mainAppUrl = "https://$productionIpAddress/";
  // static const String socketUrl = "http://$productionIpAddress:3334/";

  // MBC Agency
  static const String baseUrl = "${mainAppUrl}api/";
  static const String baseImageUrl = "${mainAppUrl}uploads/";
  static const String baseInvoiceUrl = "${baseUrl}invoice/generate-invoice?transactionId=";
  static const String doServerRegisterApiCall = "${baseUrl}auth/register";
  static const String doServerEditProfileApiCall = "${baseUrl}auth/editProfile";
  static const String doServerSplashApiCall = "${baseUrl}splash";
  static const String doServerRemoveImageApiCall = "${baseUrl}auth/removePhoto";
  static const String doServerSendCodeApiCall = "${baseUrl}auth/sendVerificationCode";
  static const String doServerAddImageApiCall = "${baseUrl}auth/addPhoto";
  static const String doServerVerifyCodeApiCall = "${baseUrl}auth/verifyCode";
  static const String doServerCreatePasswordApiCall = "${baseUrl}auth/createNewPassword";
  static const String doServerLoginApiCall = "${baseUrl}auth/login";
  static const String doServerGetCountriesApiCall = "${mainAppUrl}getCountries";
  static const String doServerGetLanguagesApiCall = "${mainAppUrl}getLanguages";
  static const String doServerAddDataApiCall = "${baseUrl}auth/adddata";
  static const String doServerCheckTokenApiCall = "${baseUrl}auth/checkToken";
  static const String checkUsername = '${baseUrl}auth/checkUsername';
  static const String googleSignIn = '${baseUrl}auth/register/google';
  static const String vibesVideo = "${baseUrl}vibes/meVideos";
  static const String publicVibesVideo = "${baseUrl}vibes/publicVideos";
  static const String draftsVideo = "${baseUrl}vibes/meDrafts";
  static const String vibes = "${baseUrl}vibes/";
  static const String vibesComments = "/comments";
  static const String vibesComment = "comment/";
  static const String vibesCommentLike = "/love";
  static const String vibesCommentUnLike = "/unlike";
  static const String vibeLike = "/like";
  static const String vibeShare = "${baseUrl}vibes/shareVideo";
  static const String searchUser = "${baseUrl}auth/searchUsers";
  static const String userDataCard = "${baseUrl}auth/cardSearch/";
  static const String userVibes = "${baseUrl}vibes/userVideos/";
  static const String removeAllHistorySearch = "${baseUrl}auth/removeAllHistorySearch";
  static const String removeSingleHistorySearch = "${baseUrl}auth/removeSingleHistorySearch/";
  static const String getAgencyDetails = "${baseUrl}agancy/getAgancyDetails?id=";
  static const String getRankedAgencies = "${baseUrl}agancy/getAgancyRank";
  static const String addCoinsToUserEndPoint = "${baseUrl}agancy/sendCoinsToUser";
  static const String sendManyToClientEndPoint = "${baseUrl}agancy/sendManyToClient";
  static const String updateAgencyEndPoint = "${baseUrl}agancy/updateAgency";
  static const String updateBroadcastAgencyEndPoint = "${baseUrl}agancyBroadcast/updateAgency";
  static const String sendManyToAgencyEndPoint = "${baseUrl}agancy/sendManyToAgency";
  static const String removeSubRechargeAgencyEndPoint = "${baseUrl}agancy/removeSubAgency";
  static const String removeSubBroadcastAgencyEndPoint = "${baseUrl}agancyBroadcast/removeSubAgency";
  static const String ageancySearchUserEndPoint = "${baseUrl}agancy/searchuser?Uid=";
  static const String applyFormBroadcastAgency = "${baseUrl}agancy/applyFormBroadcastagancy";
  static const String goLive = "${baseUrl}live/golive";
  static const String createLive = "${baseUrl}live/create";
  static const String getImages = "${baseUrl}auth/getPhotos";

  // CHAT
  static const String doServerGetAllChatsApiCall = "${baseUrl}chats";
  static const String doServerCreateOrGetChatsApiCall = "${baseUrl}chats/createorgetchat/";
  static const String doServerGetChatMessagesApiCall = "${baseUrl}chats/";
  static const String doServerSendMessageApiCall = "${baseUrl}chats/sendMessage";
  static const String doServerDeleteMessageApiCall = "${baseUrl}chats/deleteMessage";
  static const String doServerAddReactApiCall = "${baseUrl}chats/addReact";
  static const String doServerReportMessageApiCall = "${baseUrl}chats/reportMessage";
  static const String doServerGetMessageReportReasonsApiCall = "${mainAppUrl}getmessagereportreasons";

  // VIBES
  static const String vibeSocket = "vibe/";
  static const String commentSocket = "vibe/comments/";
  static const String liveSocket = "room/";

  // PROFILE
  static const String doServerGetFriendsApiCall = "${baseUrl}auth/getFriends";
  static const String doServerGetVisitorsApiCall = "${baseUrl}auth/getVisitors";
  static const String doServerGetFollowersApiCall = "${baseUrl}auth/getFollowers";
  static const String doServerGetFollowingsApiCall = "${baseUrl}auth/getFollowing";

  // Upload Vibe
  static const String doServerUploadVibeApiCall = "${baseUrl}vibes/create";

  // Live
  static const String doServerGetLivesApiCall = "${baseUrl}live/getlives";
  static const String doServerJoinLiveApiCall = "${baseUrl}live/joinlive";

  // Home
  static const String doServerGetMapApiCall = "${baseUrl}home/getMap";
  static const String getPKs = "${baseUrl}live/getPkSessionDetails";

  /// Live
  static const String getPKFriendsEndpoint = "${baseUrl}live/getpkfriends?type=";
  static const String publishDataEndpoint = "${baseUrl}live/pushdata";
  static const String doServerAcceptGuestApiCall = "${baseUrl}live/acceptInviteGuest";
  static const String doServerRemoveGuestApiCall = "${baseUrl}live/removeGuest";
  static const String rankStreamers = "${baseUrl}analysis/rank-streamers";
  static const String flames = "${baseUrl}analysis/flame";
  static const String stars = "${baseUrl}analysis/star";
  static const String gardens = "${baseUrl}analysis/garden/";
  static const String liveViewers = "${baseUrl}analysis/live/";
  static const String addModeratorEndpoint = "${baseUrl}live/addModerator";
  static const String removeModeratorEndpoint = "${baseUrl}live/removeModerator";

  static const String appleTest = "https://vibezo.org/testapple";
  static const String gifts = "${baseUrl}gifts";
  static const String getFlyComments = "${baseUrl}live/getflycomments";
  static const String sendFlyComments = "${baseUrl}live/sendflycomment";
  static const String sendGift = "${baseUrl}live/sendgiftcomment";
  static const String guestToViewer = "${baseUrl}live/guestToViewer";
  static const String muteGuest = "${baseUrl}live/muteGuest";
  static const String cameraOffGuest = "${baseUrl}live/cameraOffGuest";
  static const String sendInvitationToUser = "${baseUrl}live/sendInvitationToUser";
  static const String acceptInvitation = "${baseUrl}live/acceptInvitation";
  static const String rejectInvitation = "${baseUrl}live/rejectInvitation";
  static const String pkHistory = "${baseUrl}live/pkHistory";
  static const String kickUser = "${baseUrl}live/kickUser";
  static const String mergeLive = "${baseUrl}live/mergeLive";
  static const String addLiveToPk = "${baseUrl}live/addLiveToPk";
  static const String resetPk = "${baseUrl}live/resetPkSession";
  static const String endPk = "${baseUrl}live/endLiveFromPk";
  static const String createPk = "${baseUrl}live/createPkSession";
  static const String isMirror = "${baseUrl}live/isMirror";
  static const String setupGetFiles = "${baseUrl}setup/getFiles";
  static const String changeLiveBackground = "${baseUrl}live/changeBackground";
  static const String addTimeToParticipant = "${baseUrl}live/addTimeToParticipant";
  static const String blockUser = "${baseUrl}live/addBlock";
  static const String shareLive = "${baseUrl}live/shareLive";
  static const String liveAnalytics = "${baseUrl}live/liveAnalytics";
  static const String endLive = "${baseUrl}live/endlive";
  static const String popularLiveWithoutTokenEndpoint = "${baseUrl}live/popular?";
  static const String popularLiveWithTokenEndpoint = "${baseUrl}live/popularbyuser?";
  static const String sendGiftToComment = "${baseUrl}vibes/sendGiftVibeComment";
  static const String sendGiftToVibe = "${baseUrl}vibes/sendGiftVibe";
  static const String sendGiftToChat = "${baseUrl}chats/sendGiftChat";
  static const String renderEditCreatingVibe = "${baseUrl}rander/renderfilter";
  static const String explore = "${baseUrl}live/explore";
  static const String acceptAgencyInvitation = "${baseUrl}agancyBroadcast/acceptAgency";
  static const String getAppVersion = "${baseUrl}getVersion";

  /// Banners
  static const String doServerGetBannersApiCall = "${baseUrl}user/banners";

  /// Recharge Agency
  static const String rechargeSocket = "recharge/";
  static String doServerAllResalersApiCall = "${baseUrl}agancy/allResalers?id=";
  static String doServerSendOtpToAgencyRechargeApiCall = "${baseUrl}agancy/sendOtpToAgencyRecharge";
  static String doServerCreateAgencyPasswordRechargeApiCall = "${baseUrl}agancy/createAgencyPassword";
  static String doServerSendOtpToBroadcastApiCall = "${baseUrl}agancyBroadcast/sendOtpToAgencyRecharge";
  static String doServerCreateSubAgencyApiCall = "${baseUrl}agancyBroadcast/createSubAgency";
  static String doServerCreateSubRechargeAgencyApiCall = "${baseUrl}agancy/createSubAgency";

  /// Recharge Agency
  static const String broadcastSocket = "broadcast/";
  static String doServerRankedBroadcastApiCall = "${baseUrl}agancyBroadcast/rankBroadcast";
  static String doServerBroadcastAgencyDataApiCall = "${baseUrl}agancyBroadcast/getAgancyDetails";
  static String doServerFetchStreamerAnalyticsApiCall = "${baseUrl}agancyBroadcast/getStreamerAnalytics";
  static String doServerFetchSubAgenciesBroadcastApiCall = "${baseUrl}agancyBroadcast/subAgancyBroadcast/";
  static String doServerFetchAgencyAnalyticsBroadcastApiCall = "${baseUrl}agancyBroadcast/getAgancyAnalytics";

  /// Rank
  static const String rankStreamerApiCall = "${baseUrl}rank/streamerRankPage";
  static const String rankSupporterApiCall = "${baseUrl}rank/supporterRankPage";
  static const String rankViewAllCountryApiCall = "${baseUrl}rank/viewAllCountry";

  /// Wallet
  static const String walletSocket = "wallet/";
  static const String doServerGetWalletDataApiCall = "${baseUrl}wallet/getWallet";
  static const String doServerWalletSendOTPApiCall = "${baseUrl}wallet/sendOtpToUser";
  static const String doServerWalletSearchUserApiCall = "${baseUrl}wallet/searchuser?Uid=";
  static const String doServerGetRechargeAgencyApiCall = "${baseUrl}wallet/getRechargeAgency";
  static const String doServerCreatePaymentSessionApiCall = "${baseUrl}wallet/create-payment-session";
  static const String doServerSendManyWithdrawToUserApiCall = "${baseUrl}wallet/sendManyWithdrawToUser";
  static const String doServerCreateWithdrawToBankAccountApiCall = "${baseUrl}wallet/createWithdrawToBankAccount";
  static const String doServerGetHistoryTransactionsWithdrawApiCall = "${baseUrl}wallet/historyTransactionsWithdraw";
  static const String doServerGetHistoryTransactionsRechargeApiCall = "${baseUrl}wallet/historyTransactionsRecharge";

  /// Levels
  static const String doServerGetLevels = "${baseUrl}levels";

  /// donation
  static const String donationEndpoint = "${baseUrl}donates/";
  static const String donationHistoryEndpoint = "${baseUrl}donates/getDonationHistory";
  static const String donationHistoryByIdEndpoint = "${baseUrl}donates/getDonationHistory/";

  /// Setting
  static const String doServerGetPrivacyApiCall = "${baseUrl}auth/getSettings";
  static const String doServerDeleteAccountApiCall = "${baseUrl}auth/deleteAccount";
  static const String doServerUpdatePrivacyApiCall = "${baseUrl}auth/updateSettings";
  static const String doServerGetBlockedUsersApiCall = "${baseUrl}auth/getBlockedUsers";

  /// Reports
  static const String getReportsReasonsEndpoint = "${baseUrl}report/getReportReasons";
  static const String sendReportEndpoint = "${baseUrl}report/createReport";
  static const String itemBagPackageEndpoint = "${baseUrl}itembagPackages";

  /// Notifications
  static const String doServerGetNotificationsApiCall = "${baseUrl}auth/getNotification";
  static const String applyForRechargeAgencyEndpoint = "${baseUrl}agancy/applyFormRechargeagancy";

  /// Location
  static const String getLocationEndpoint = "${baseUrl}getlocation";

  //otp verification agency
  static const String verifyAgencyOtpEndpoint = "${baseUrl}agancy/sendOtpToWhatsApp";
}
