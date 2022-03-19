<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>



<%
  request.setCharacterEncoding("utf-8");
  String id= request.getParameter("idValue");
  String pw=request.getParameter("pwValue");

  //데이트베이스 연결 
  Class.forName("com.mysql.jdbc.Driver");
  Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/stageusDB",//데이터베이스 명
  "stageus","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호

  //데이터 베이스 쿼리 전달
  String sql="SELECT * FROM account WHERE id=? and  pw= ?";//데이터 베이스는 넣고 싶은 값에 ?로 해서 나중에 값을 넣을 수 있다. 
  PreparedStatement query =connect.prepareStatement(sql);//?를 한 곳에 값을 넣어 주기 위한 preparedStatement 미리 선언된 것
  query.setString(1,id);
  query.setString(2,pw);

  //데이트 베이스로 sql 전송 및 값 반환
  //값을 받아 줄  곳 
  ResultSet result =query.executeQuery();//값이 전달 되고 쿼리 값이 저장 된다.  result 값을 배열로 저장 해서 사용 해야 한다. 
  
    String[][] data = new String[100][3];
     //ArrayList<String> data = new ArrayList<String>();

  int idx =0;
   while(result.next()){
        data[idx][0]=Integer.toString(result.getInt(1));
        data[idx][1]=result.getString(2);
        data[idx][2]=result.getString(3);
        idx++;
    }

  //다음 줄을 받오 오고 싶다. next()를 사용 한다. 

  //데이터 SQL 전송
  //query.executeUpdate();

 // 주의 데이터 베이스 꺼 주기  역순으로 넣어 줘야 한다. 통신을 닫아 줘야 한다. 그렇지 않으면 이미데이터 베이스 연결 되여 있으니 그거 쓰라는 에로가 뜬다. 
 result.close();
 query.close();
 connect.close(); 
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>week7 mainPage</title>
</head>
<body>
    <h1>mainPage</h1>
    <p>아이디: <%=id%> </p>
    <p> 비밀번호 : <%=pw%></p>
    
    <script>
    //   var dataList = <%=data%>
    //     for(var i =0; i<100; i++){
    //         console.log(dataList[i][0],dataList[i][1],dataList[i][2]);
    //     }

    <% for(int a=0; a<100; a++){ %>
        console.log("<%=data[a][0]%>" ,"<%=data[a][1]%>","<%=data[a][2]%>");
   <% } %>
    </script>
</body>
</html>