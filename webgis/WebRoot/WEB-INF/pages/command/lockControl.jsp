
<%@ include file="/common/taglibs.jsp"%>
<!--分页查询共用的页面-->
<%@ include file="/common/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>


<script>
$().ready(function() {
	 $("#entityForm").validate(); //初始化验证信息

	 var defaultRoleId = "";// //取出当前车辆的车牌颜色，默认选中
	//ajax填充下拉框数据 填充监听类型 选项
	 //$("#listenType").lookup({category:"ListenTerminal", selectedValue:defaultRoleId});
	 Utility.ajaxSubmitForm("entityForm");
});
</script>
 <BODY>
	<form id="entityForm" name="entityForm" 
			action='<%=ApplicationPath%>/command/doorControl.action' method="POST">
				
        <input type="hidden"  name="vehicleId"  id="vehicleId" value="${vehicleId}"/>
  <table width="100%"  class="TableBlock">
					<tbody><tr>
						<td colspan="2" style="font-weight: bold; background: #EFEFEF;" height="25">锁控制
						<span style="color:red;background:blue;">${message}</span>
						</td>
					</tr>
					<tr>
						<td align="right">控制类型
							:</td>
						<td><select id="listenType"  style="width: 150px;" name="listenType" class="required digits">
						<option value="0">开锁</option>
						<option value="1">锁闭</option>
						   </select></td>
					</tr>
				

						<td colspan=2 align="center"><button type="submit" class="sendjson" >发送</button> </td>
						
					</tr>

				
					
				</tbody></table>
 </BODY>
</HTML>
