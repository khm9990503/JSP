package kr.co.jboard1.db;

public class Sql {
	
	// user
	public static final String INSERT_USER = "INSERT INTO `board_user` SET "
											+ "`uid`=?, "
											+ "`pass`=SHA2(?,256), "
											+ "`name`=?, "
											+ "`nick`=?, "
											+ "`email`=?, "
											+ "`hp`=?, "
											+ "`rdate`=NOW(), "
											+ "`regip`=?, "
											+ "`zip`=?, "
											+ "`addr1`=?, "
											+ "`addr2`=?";
	public static final String SELECT_USER = "select * from `board_user` where `uid`=? and `pass`=SHA2(?,256)";
	public static final String SELECT_COUNT_UID = "select count('uid') from `board_user` where `uid`=?";
	public static final String SELECT_COUNT_NICK = "select count('nick') from `board_user` where `nick`=?";
	public static final String SELECT_TERMS = "select * from `board_terms`";
	
	// board
	public static final String INSERT_ARTICLE = "insert into `board_article` set "
												+ "`title`=?, "
												+ "`content`=?, "
												+ "`file`=?, "
												+ "`uid`=?, "
												+ "`regip`=?, "
												+ "`rdate`=NOW()";
	public static final String INSERT_FILE = "insert into `board_file` set "
											+"`parent`=?, "
											+"`newName`=?, "
											+"`oriName`=?, "
											+"`rdate`=NOW()";
	public static final String INSERT_COMMENT = "insert into `board_article` set "
											+ "`parent`=?, "
											+ "`content`=?, "
											+ "`uid`=?, "
											+ "`regip`=?, "
											+ "`rdate`=NOW()";
	public static final String SELECT_MAX_NO = "select max(`no`) from `board_article`";
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`no`) FROM `board_article` where `parent`=0";
	
	public static final String SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `board_article` AS a JOIN `board_user` AS b ON a.uid = b.uid "
												+ "where `parent`=0 "
												+ "order by `no` desc "
												+ "limit ?,10";
	public static final String SELECT_ARTICLE = "SELECT a.*, b.`fno`, b.`oriName`, b.`download` "
												+ "FROM `board_article` AS a "
												+ "left JOIN `board_file` AS b "
												+ "ON a.`no`=b.`parent` "
												+ "WHERE `no`=?";
	
	public static final String SELECT_FILE = "select * from `board_file` where `fno`=?";
	public static final String SELECT_COMMENTS = "select a.*,b.nick from `board_article` as a "
												+ "join `board_user` as b using (`uid`) "
												+ "where `parent`=? order by `no` asc";
	public static final String SELECT_COMMENT_LATEST = "SELECT a.*,b.nick FROM `board_article` AS a "
														+ "JOIN `board_user` AS b USING(`uid`) "
														+ "WHERE `parent`!=0 ORDER BY `no` DESC LIMIT 1";
	
	public static final String UPDATE_ARTICLE_HIT = "update `board_article` set `hit` = `hit` + 1 where `no`=?";
	public static final String UPDATE_FILE_DOWNLOAD = "update `board_file` set `download`=`download`+1 where `fno`=?";
	
	public static final String UPDATE_COMMENT = "UPDATE `board_article` SET `content`=?, `rdate`=NOW() WHERE `no`=?";
	public static final String UPDATE_COMMENT_COUNT_PLS = "UPDATE `board_article` SET `comment`=`comment`+1 WHERE `no`=?";
	public static final String UPDATE_COMMENT_COUNT_MNS = "UPDATE `board_article` SET `comment`=`comment`-1 WHERE `no`=?";
	
	public static final String DELETE_COMMENT = "DELETE FROM `board_article` WHERE `no`=?";
}
