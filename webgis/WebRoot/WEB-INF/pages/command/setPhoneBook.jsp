
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
  
	
<script type="text/javascript" src="<%=jsPath%>/jquery/jquery.timers.js"></script><!--定时器-->
<script type="text/javascript" src="<%=jsPath%>/terminalCommand.js"></script><!--命令结果查询-->
</head>

		<script type="text/javascript" charset="utf-8">

		var queryParam = {};

		var queryItems = {};
function getDeleteActionColumn(value, rowData, rowIndex)
			{  
				var rowNo = value;
				var html =  "<img style='cursor: pointer;' src='<%=imgPath%>/cross.gif' onclick=\"removeRow('" +rowNo+"');\"/>";
				return html;
			}
		
//设置电话本命令执行结果
function doSubmit()
{	
	//alert(times);
       var url = "<%=ApplicationPath%>/command/phoneBook.action";
	  //var commandId = 0;
	 //var params = {enclosures:["1","2"]};
	 var tagIds = [];
	 var phoneNumbers = [];
	 var contacts = [];
	 for(var key in queryItems)
	{
		 var item = queryItems[key];
		 if(item.tagId)
		{
		 tagIds.push(item.tagId);
		 phoneNumbers.push(item.phoneNumber); 
		 contacts.push(item.contact);
		}
	}
	var configType = $("#configType").val();
	if(tagIds.length==0  && configType != 0)
	{
		$.messager.alert("提示","请添加电话联系人!");
		return;
	}
	if(configType.length == 0)
	{
		$.messager.alert("提示","请选择设置类型!");
		return;
	}
	var params = {tagIds:tagIds, phoneNumbers:phoneNumbers, contacts:contacts, configType:configType, vehicleId:"${vehicleId}"};
	//alert($.param( params, true ));
	   $.post(url, $.param( params, true ), 
			function(result){		
		          //alert(result);
				  if(result.success == true)
				 { 
					    var commandId = result.data; //下发成功后，获取到命令Id
						TerminalCommand.startQueryResult(commandId);//命令下发成功,根据命令id,开始尝试获取检索结果
					   //alert("下发成功");
				  }else {
                       $(".commandMsg").html("提交失败! 错误原因：" + (result.message ? result.message : result.Data));
									//停止所有的在$('body')上定时器  
					   TerminalCommand.stopQuery();  
				  }
		  }
	  );
}


var datatable;
//添加新表
var rowId = 0;
function addrow() {
	if($("#entityForm").valid() == false)
		return; //验证失败

	var tagId =  $('#tag').val();
	var tagName = $('#tag').find("option:selected").text();
	//queryParam[tagId] = $('#enclosure').val() + ","+ $('#phoneNumber').val()+","+$('#contact').val();
	var item = {tag: tagName,
        phoneNumber:$('#phoneNumber').val(),
       contact: $('#contact').val() , rowId:rowId, tagId:tagId};
	if(isExistInTable(item))
	{
		$.messager.alert("提示","该联系人已经添加到列表中!");
		return;
	}
	$("#queryGrid").datagrid("appendRow",item);

	queryItems[rowId] = item;
	rowId++;
   
}

function removeRow(rowId)
{
	var row = $("#queryGrid").datagrid('getSelected');
    if (row) {
         var rowIndex = $("#queryGrid").datagrid('getRowIndex', row);
         $("#queryGrid").datagrid('deleteRow', rowIndex);
    }
	delete queryItems[rowId]; //删除这一行的数据
}

function isExistInTable(newItem)
{

	for(var key in queryItems)
	{
		 var item = queryItems[key];
		 if(item.tagId == newItem.tagId && item.phoneNumber==newItem.phoneNumber 
			 &&  item.contact==newItem.contact)
		{
			 return true;
		}
	}
	return false;

}

			$(document).ready(function() {
				 $("#entityForm").validate(); //初始化验证信息
			     //ajax填充下拉框数据
			       $("#configType").lookup({category:"PhoneBook", selectedValue:""});
				
			} );
		</script>
<body>
		<div id="toolbar" >		
			 <form id="entityForm" method="post" action="<%=ApplicationPath%>/command/configPhoneBook.action">
        <input type="hidden"  name="vehicleId"  id="vehicleId" value="${vehicleId}"/>
		&nbsp;&nbsp;</select>&nbsp;&nbsp;
  <table width="100%"  class="TableBlock">
					<tbody>
					<tr>
					<td align="right">设置类型:</td><td colspan=6><select id="configType" name="configType"  style="width: 150px;">  
					<input type="button" class="sendjson" value="发送" onclick="doSubmit();">
						   <span class="commandMsg"></span></td>
					</td>
					</tr>
					<tr>
						<td align="right">设置标志:</td>
						<td><select id="tag"  style="width: 100px;" name="tag" class="required">
						       <option value=1>呼入</option>
						       <option value=2>呼出</option>
						       <option value=3>呼入/呼出</option>
						   </select>
						  </td>

						<td align="right">电话号码:</td>
						<td >
							  <input type="text" name="phoneNumber" id="phoneNumber"  value='' class="required digits"  size=12></input>
						
						<td align="right">联系人:</td>
						<td>
							  <input type="text" name="contact" id="contact" value='' class="required" size=10></input>
						</td>
					

						<td  align="left" colspan=2>
						<input type="button" value="添加联系人" onclick="addrow();">
						</td>
						
					</tr>
				</tbody></table>
				</form>
				</div>
<table id="queryGrid" class="easyui-datagrid" 
						data-options="singleSelect:true,rownumbers:true,striped:true,fitColumns: true,
						fit:true,toolbar:'#toolbar',
						url:'',method:'post'">
					<thead>
						<tr>
							<th data-options="field:'tag'" width="18%">标志</th>
							<th data-options="field:'phoneNumber'" width="15%">电话号码</th>
							<th data-options="field:'contact'" width="15%">联系人</th>
							<th data-options="field:'rowId',formatter:getDeleteActionColumn" width="5%">删除</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>					
				</table>



</body>

