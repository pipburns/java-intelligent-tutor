/**
 * 
 */
package itjava.model;

import itjava.data.LocalMachine;
import itjava.util.KeyValue;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

/**
 * Factory class for storing, accessing and updating TutorialInfo into database.
 * @author Aniket
 * 
 */
public class TutorialInfoStore {

	/**
	 * Inserts the list of {@link TutorialInfo} passed as params into database.
	 * @param tutorialInfoList
	 */
	public static ArrayList<Integer> InsertInfoList(ArrayList<TutorialInfo> tutorialInfoList){
		ArrayList<Integer> tutorialIdList = new ArrayList<Integer>();
		for (TutorialInfo tutorialInfo : tutorialInfoList) {
			tutorialIdList.add(InsertInfo(tutorialInfo));
		}
		return tutorialIdList;
	}
	
	/**
	 * Inserts TutorialInfo into database.
	 * @param tutorialInfo {@link TutorialInfo}
	 * @return The ID auto-generated by the database.
	 */
	public static int InsertInfo(TutorialInfo tutorialInfo) {
		Connection _conn = null;
		int tutorialInfoId = -1;
		try{	
			_conn = GetConnection();
			System.out.println("Current tutorialInfo folderName : " + tutorialInfo.getFolderName());
			String columns = "folderName, tutorialName, tutorialDescription, numExamples, numQuizes, createdBy, userLevel";
			String placeholders = "?, ?, ?, ?, ?, ?, ?";
			String insertSql = "insert into TutorialInfo(" + columns + ") values( " + placeholders + " )";
			PreparedStatement insertStmt = _conn.prepareStatement(insertSql);
			insertStmt.setString(1, tutorialInfo.getFolderName());
			insertStmt.setString(2, tutorialInfo.getTutorialName());
			insertStmt.setString(3, tutorialInfo.getTutorialDescription());
			insertStmt.setInt(4, tutorialInfo.getNumExamples());
			insertStmt.setInt(5, tutorialInfo.getNumQuizes());
			insertStmt.setString(6, tutorialInfo.getCreatedBy());
			insertStmt.setString(7, tutorialInfo.getUserLevel());
			
			insertStmt.executeUpdate();
			ResultSet rs = insertStmt.getGeneratedKeys();
			rs.next();
			tutorialInfoId = rs.getInt(1);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				CloseConnection(_conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return tutorialInfoId;
	}

	/**
	 * Reads TutorialInfo from the storage and returns an {@link ArrayList} of 
	 * {@link TutorialInfo} according to the parameter <i>whereClause</i>.
	 * @param whereClause <key, value> pairs expressing the required attributes
	 * @return ArrayList of TutorialInfo objects.
	 */
	public static ArrayList<TutorialInfo> SelectInfo(HashMap<String, String> whereClause) {
		Connection _conn = null;
		ArrayList<TutorialInfo> tutorialInfoList = new ArrayList<TutorialInfo>();
		try {
			_conn = GetConnection();
			String selectSql = "select * from TutorialInfo ";
			if (whereClause != null) {
				if (!whereClause.isEmpty()) {
					selectSql += "where ";
					Iterator<Entry<String, String>> it = whereClause.entrySet().iterator();
					while (it.hasNext()) {
						Entry<String, String> entry = it.next();
						selectSql += entry.getKey() + "=\"" + entry.getValue() + "\"";
						if (it.hasNext()) {
							selectSql += " and ";
						}
						else {
							selectSql += ";";
						}
					}
				}
			}
			PreparedStatement selectStmt = _conn.prepareStatement(selectSql);
			ResultSet result = selectStmt.executeQuery();
			System.out.println("Where clause size for TutorialInfo:" + ((whereClause == null)? 0 : whereClause.size()));
			int numOfRowsReturned = 0;
			while (result.next()) {
				numOfRowsReturned++;
				int tutorialInfoId = result.getInt("tutorialInfoId");
				String folderName = result.getString("folderName");
				String tutorialName = result.getString("tutorialName");
				String tutorialDescription = result.getString("tutorialDescription");
				int numExamples = result.getInt("numExamples");
				int numQuizes = result.getInt("numQuizes");
				String creationDate = result.getString("creationDate");
				String createdBy = result.getString("createdBy");
				String userLevel = result.getString("userLevel");
				int timesAccessed = result.getInt("timesAccessed");
				tutorialInfoList.add(new TutorialInfo(tutorialInfoId, folderName, tutorialName, 
						tutorialDescription, numExamples, numQuizes, creationDate, 
						createdBy, timesAccessed, userLevel));
			}
			System.out.println("Corresponding # of rows:" + numOfRowsReturned);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			try {
				CloseConnection(_conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return tutorialInfoList;
	}
	
	/**
	 * Reads TutorialInfo from the storage and returns an {@link ArrayList} of 
	 * {@link TutorialInfo} according to the parameter <i>whereClause</i>.
	 * @param whereClause <key, value> pairs expressing the required attributes
	 * 		  value includes both table column and search type (="value", LIKE "value", LIKE%value%)
	 * @return ArrayList of TutorialInfo objects.
	 */
	public static ArrayList<TutorialInfo> SearchTutorials(HashMap<String, String> whereClause) {
		Connection _conn = null;
		ArrayList<TutorialInfo> tutorialInfoList = new ArrayList<TutorialInfo>();
		try {
			_conn = GetConnection();
			String selectSql = "select * from TutorialInfo ";
			if (whereClause != null) {
				if (!whereClause.isEmpty()) {
					selectSql += "where ";
					Iterator<Entry<String, String>> it = whereClause.entrySet().iterator();
					while (it.hasNext()) {
						Entry<String, String> entry = it.next();
						selectSql += entry.getKey() + entry.getValue();
						if (it.hasNext()) {
							selectSql += " and ";
						}
						else {
							selectSql += ";";
						}
					}
				}
			}
			PreparedStatement selectStmt = _conn.prepareStatement(selectSql);
			ResultSet result = selectStmt.executeQuery();
			System.out.println("Where clause size for TutorialInfo:" + ((whereClause == null)? 0 : whereClause.size()));
			int numOfRowsReturned = 0;
			while (result.next()) {
				numOfRowsReturned++;
				int tutorialInfoId = result.getInt("tutorialInfoId");
				String folderName = result.getString("folderName");
				String tutorialName = result.getString("tutorialName");
				String tutorialDescription = result.getString("tutorialDescription");
				int numExamples = result.getInt("numExamples");
				int numQuizes = result.getInt("numQuizes");
				String creationDate = result.getString("creationDate");
				String createdBy = result.getString("createdBy");
				String userLevel = result.getString("userLevel");
				int timesAccessed = result.getInt("timesAccessed");
				tutorialInfoList.add(new TutorialInfo(tutorialInfoId, folderName, tutorialName, 
						tutorialDescription, numExamples, numQuizes, creationDate, 
						createdBy, timesAccessed, userLevel));
			}
			System.out.println("Corresponding # of rows:" + numOfRowsReturned);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			try {
				CloseConnection(_conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return tutorialInfoList;
	}
	
	/**
	 * Updates the property of persistent object {@link TutorialInfo} with the new value from the < key, value > pair
	 * @param tutorialInfoId Primary key of the {@link TutorialInfo} to be updated
	 * @param keyValuePair < key, value >
	 */
	public static void UpdateInfo(int tutorialInfoId, KeyValue<String, String> keyValuePair) {
		Connection conn = null;
		String key = keyValuePair.getKey();
		String quotes = (key.equals("numExamples") || key.equals("numQuizes") || key.equals("timesAccessed")) ? "" : "\"";
		try {
			conn = GetConnection();
			String updateSql = "update TutorialInfo set " + keyValuePair.getKey() + "=" + quotes + keyValuePair.getValue() + quotes + " " +
					"where tutorialInfoId = ?";
			PreparedStatement stmt = conn.prepareStatement(updateSql);
			stmt.setInt(1, tutorialInfoId);
			int rowsUpdated = stmt.executeUpdate();
			if (rowsUpdated != 1) throw new Exception("Num of rows updated : " + rowsUpdated);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			try {
				CloseConnection(conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private static Connection GetConnection() throws Exception {
		Class.forName("org.sqlite.JDBC");
		return DriverManager.getConnection("jdbc:sqlite:" + LocalMachine.home + "samples/itjava.db");
	}
	private static void CloseConnection(Connection conn) throws SQLException {
		conn.close();
	}
}