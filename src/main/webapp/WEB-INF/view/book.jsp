<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/8/24
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>图书</title>

    <jsp:include page="/common/head.jsp"></jsp:include>
</head>
<body>
<div id="addBookDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">图书名称</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_name" placeholder="请输入图书名称..">
            </div>

        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">图书价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control"  id="add_price" placeholder="请输入价格..">
            </div>

        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">出版日期</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_dateTime" placeholder="请输入出版日期..">
            </div>
        </div>
    </form>
</div>
<div id="updateBookDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">图书名称</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_name" placeholder="请输入图书名称..">
            </div>

        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">图书价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control"  id="update_price" placeholder="请输入价格..">
            </div>

        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">出版日期</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_dateTime" placeholder="请输入出版日期..">
            </div>
        </div>
    </form>
</div>
<button class="btn btn-info" type="button" onclick="addBook()"><i class="glyphicon glyphicon-plus"></i>添加</button>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-info">
            <div class="panel-heading">图书</div>
            <table id="example" class="table table-hover table-condensed" class="display" >
                <thead>
                <tr class="danger">
                    <th>序号</th>
                    <th>图书名</th>
                    <th>图书价格</th>
                    <th>出版日期</th>
                    <th>操作</th>
                </tr>
                </thead>

            </table>

        </div>
    </div>
</div>
</body>
<jsp:include page="/common/script.jsp"></jsp:include>

<script>

    var addBookForm;
    var updateBookForm;
    $(function () {
        bookData()
        addBookForm = $("#addBookDiv").html();
        updateBookForm = $("#updateBookDiv").html();
        infoDate("add_dateTime")
        infoDate("update_dateTime")
    })
    //查询
    var bookTable;
    function bookData() {
        bookTable= $('#example').DataTable({
            "serverSide": true,//开启服务的模式
            "searching": false,
            "ajax":{
                url: "/book/queryBooks.csw",
                type: "post",
                dataSrc: function (result) {
                    if (result.code == 200) {
                        result.draw = result.data.draw;
                        result.recordsTotal = result.data.recordsTotal;
                        result.recordsFiltered = result.data.recordsFiltered;
                        result.data = result.data.data;
                        return result.data;
                    }
                },
            },

            "lengthMenu": [3, 5, 10, 20],
            "language": {
                "url": "/js/DataTables-1.10.18/Chinese.json"
            },

                "columns": [
                {"data": "id"},
                {"data": "name"},
                {"data": "price"},
                { "data": "dateTime" ,render:function (a,b,c,d) {
                        return moment(a).format("YYYY-MM-DD")
                    }},
                {
                    "data": "id", render: function (data, type, row, meta) {
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "                            <button type=\"button\" class=\"btn btn-info\" onclick='showBook(" + data + ")'><span class='glyphicon glyphicon-pencil'></span>修改</button>\n" +
                            "                            <button type=\"button\" class=\"btn btn-danger\" onclick='delBook(" + data + ")'><span class='glyphicon glyphicon-trash'></span>删除</button>\n" +
                            "                            </div>"

                    }
                }
            ]
        });
    }


    //新增
    var getAddBootBox;
    function  addBook() {
        getAddBootBox= bootbox.dialog({
            message: $("#addBookDiv   form"),
            title: "新增用户",          //确认标题
            buttons: {                   //按钮
                Cancel: {                 //取消
                    label: "取消",          //标签:取消
                    className: "btn btn-warning",   // 类名:btn-default
                    callback: function () {     //回调:函数(){}

                    }
                }
                , OK: {
                    label: "提交",
                    className: "btn-primary",
                    callback: function () {
                        var data={};
                        var name=$("#add_name",getAddBootBox).val();
                        var price=$("#add_price",getAddBootBox).val();
                        var dateTime=$("#add_dateTime",getAddBootBox).val();

                        data.name=name;
                        data.price=price;
                        data.dateTime=dateTime;
                        $.ajax({
                            //配置求路径
                            url: '/book/addBook.csw',
                            //发送请求方式默认为get
                            type: 'post',
                            //期望的返回值类型配置有text和json,
                            dataType: "json",
                            //{}发送请求是传递的参数，写法（{“name”：name,"pwd":pwd}）
                            data: data,
                            success: function (result) {
                                if(result.code=="200"){
                                    bootbox.alert({
                                        size: "small",
                                        message:result.msg,
                                        //刷新
                                    })
                                    location.reload()
                                }

                            },

                        });
                    }
                },
            }

        })
        $("#addBookDiv").html(addBookForm);
        infoDate("add_dateTime");
    }


    //删除
    function delBook(id) {

        bootbox.confirm({
            message: "是否确认删除?",
            buttons: {
                confirm: {
                    label: '是',
                    className: 'btn-success'
                },
                cancel: {
                    label: '否',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result == true) {
                    $.ajax({
                        //配置求路径
                        url: '/book/delBook.csw',
                        //发送请求方式默认为get
                        type: 'post',
                        //期望的返回值类型配置有text和json,
                        dataType: "json",
                        //{}发送请求是传递的参数，写法（{“name”：name,"pwd":pwd}）
                        data: {"id": id},
                        success: function (data) {
                            if (data.code == 200) {
                                bootbox.alert({
                                    size: "small",
                                    message:"成功",
                                    //刷新
                                })
                                location.reload()
                            }
                        },

                    });
                }

            }
        });

    }


    //回显修改
    var getShowBox;
    function showBook(id) {

        $.ajax({
            //配置求路径
            url: '/book/showBook.csw',
            //发送请求方式默认为get
            type: 'post',
            //期望的返回值类型配置有text和json,
            dataType: "json",
            //{}发送请求是传递的参数，写法（{“name”：name,"pwd":pwd}）
            data: {"id": id},
            success: function (result) {
                if (result.code == "200") {
                    var name = result.data.name;
                    var price = result.data.price;
                    var dateTime = result.data.dateTime;

                    $("#update_name").val(name);
                    $("#update_price").val(price);
                    $("#update_dateTime").val(dateTime);

                    getShowBox = bootbox.dialog({
                        message: $("#updateBookDiv  form"),
                        title: "修改用户",          //确认标题
                        buttons: {                   //按钮
                            Cancel: {                 //取消
                                label: "取消",          //标签:取消
                                className: "btn btn-warning",   // 类名:btn-default
                                callback: function () {     //回调:函数(){}

                                }
                            }
                            , OK: {
                                label: "提交",
                                className: "btn-primary",
                                callback: function () {
                                    var dataJson = {};

                                    var name = $("#update_name").val();
                                    var price = $("#update_price").val();
                                    var dateTime = $("#update_dateTime").val();

                                    dataJson.name = name;
                                    dataJson.price = price;
                                    dataJson.dateTime = dateTime;
                                    dataJson.id = id;


                                    $.ajax({
                                        //配置求路径
                                        url: '/book/updateBook.csw',
                                        //发送请求方式默认为get
                                        type: 'post',
                                        //期望的返回值类型配置有text和json,
                                        dataType: "json",
                                        //{}发送请求是传递的参数，写法（{“name”：name,"pwd":pwd}）
                                        data: dataJson,
                                        success: function (result) {
                                            if (result.code == "200") {
                                                bootbox.alert({
                                                    size: "small",
                                                    message:result.msg,
                                                    //刷新
                                                })
                                                location.reload()
                                            }

                                        }

                                    })
                                }
                            }
                        }

                    })
                } else {
                    alert("失败")
                }

            }
        })

        $("#updateBookDiv").html(updateBookForm)

        infoDate("update_dateTime");
    }

    //日期
    function infoDate(Elements){
        $("#"+Elements).datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale: moment.locale('zh-CN')
        });
    }
</script>

</html>
