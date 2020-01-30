package election;

public class ParameterBox {

private static String userID;
private static String password;
private static String VoteFlag;
private static int ConstituencyID;
private static String DistrictName;
private static String Nickname;
private static String VoteFlag_Decision;


//ユーザーID
public static String getuserID() {
	return userID;
}
public static void setuserID(String userID) {
	ParameterBox.userID = userID;
}

//パスワード
public static String getpassword() {
	return password;
}
public static void setpassword(String password) {
	ParameterBox.password = password;
}

//投票フラグ
public static String getvoteflag() {
	return VoteFlag;
}
public static void setvoteflag(String voteflag) {
	ParameterBox.VoteFlag = voteflag;
}

//投票地区
public static int getConstituencyID() {
	return ConstituencyID;
}
public static void setConstituencyID(int constituencyID) {
	ConstituencyID = constituencyID;
}

//投票力立候補者名
public static String getDistrictName() {
	return DistrictName;
}
public static void setDistrictName(String districtname) {
	DistrictName = districtname;
}

//ユーザーニックネーム
public static String getnickname() {
	return Nickname;
}
public static void setnickname(String nickname) {
	Nickname = nickname;
}

//投票対象立候補者ID
public static String getVoteFlag_Decision() {
	return VoteFlag_Decision;
}
public static void setVoteFlag_Decision(String voteFlag_Decision) {
	VoteFlag_Decision = voteFlag_Decision;
}

}
