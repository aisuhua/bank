$.extend( true, $.fn.dataTable.defaults, {
    language: {
        "sProcessing": "处理中...",
        "sLengthMenu": "显示 _MENU_ 项结果",
        "sZeroRecords": "没有匹配结果",
        "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
        "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
        "sInfoPostFix": "",
        "sSearch": "搜索:",
        "sUrl": "",
        "sEmptyTable": "表中数据为空",
        "sLoadingRecords": "载入中...",
        "sInfoThousands": ",",
        "oPaginate": {
            "sFirst": "首页",
            "sPrevious": "上页",
            "sNext": "下页",
            "sLast": "末页"
        },
        "oAria": {
            "sSortAscending": ": 以升序排列此列",
            "sSortDescending": ": 以降序排列此列"
        },
        select: {
            rows: {
                _: "选中 %d 项",
                1: "选中 1 项",
                0: ""
            }
        }
    }
});

/**
 * pnotify
 */
PNotify.defaults.styling = 'bootstrap3';
PNotify.defaults.icons = 'bootstrap3';

function getTextWidth(text, font) {
    // re-use canvas object for better performance
    var canvas = getTextWidth.canvas || (getTextWidth.canvas = document.createElement("canvas"));
    var context = canvas.getContext("2d");
    context.font = font;
    var metrics = context.measureText(text);
    return metrics.width;
}

function clearSuccess() {
    if (PNotify.notices.length > 0) {
        $.each(PNotify.notices, function( index, value ) {
            if (value.options.data.type == 'success') {
                PNotify.notices[index].remove();
            }
        });
    }
}

function applyDefault(options = {}) {
    options.addClass = "pnotify-word-break";
    options.textTrusted = true;

    return options;
}

function success(message, options = {}) {
    clearSuccess();

    options.text = message;
    // options.delay = 1500;
    options = applyDefault(options);
    PNotify.success(options);
}

function error(message, options = {}) {
    clearSuccess();

    options.text = message;
    options = applyDefault(options);
    PNotify.error(options);
}

function info(message, options = {}) {
    clearSuccess();

    options.text = message;
    options = applyDefault(options);
    PNotify.info(options);
}

function notice(message, options = {}) {
    clearSuccess();

    options.text = message;
    options = applyDefault(options);
    PNotify.notice(options);
}

function flash() {
    // 先关闭已有的提示窗
    PNotify.closeAll();
    // clearSuccess();

    var $pnotify = $('.pnotify');

    if($pnotify.size() <= 0) {
        return false;
    }

    $pnotify.each(function() {
        var $that = $(this);

        // 只显示最后一条提醒
        // if ($(this)[0] !== $pnotify.last()[0]) {
        //     $that.remove();
        //     return true;
        // }

        var message = $that.html();

        if($that.hasClass('alert-success')) {
            success(message);
        } else if($that.hasClass('alert-danger')) {
            error(message);
        } else if($that.hasClass('alert-info')) {
            info(message);
        } else if($that.hasClass('alert-warning')) {
            notice(message);
        }

        $that.remove();
    });
}

/**
 * Pjax
 */
//maximum cache size for previous container contents
//https://github.com/defunkt/jquery-pjax
// $.pjax.defaults.maxCacheLength = 0;
// $.pjax.defaults.timeout = 180000;
//
// $(document).pjax('a:not([data-nopush], [data-nopjax])', '#pjax-container');
// $(document).pjax('a[data-nopush]', '#pjax-container', {
//     push: false
// });
//
// $(document).on('submit', 'form[data-pjax]', function(event) {
//     $.pjax.submit(event, '#pjax-container');
// });
//
// $(document).on('pjax:timeout', function() {
//     console.log('pjax.timeout');
// });

/**
 * NProgress
 */
$(document).on('pjax:send', function() {
    NProgress.start();
});

$(document).on('pjax:complete', function() {
    NProgress.done();
});

$(document).on("pjax:end", function() {
    flash();
});

$(document).on('ajaxStart', function() {
    NProgress.start();
});

$(document).on('ajaxStop', function() {
    NProgress.done();
});

// $(document).ready(function(){
//     NProgress.start();
// });
// $(window).load(function(){
//     NProgress.done();
// });

$(function () {
    flash();

    // $('.my-tabs1 li').click(function (e) {
    //     $(this).addClass('active');
    //     $(this).siblings('li').removeClass('active');
    // })
});


