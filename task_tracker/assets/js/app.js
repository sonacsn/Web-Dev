// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function update_buttons() {
  $('.manage-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manage = $(bb).data('manage');
    if (manage != "") {
      $(bb).text("Unmanage");
    }
    else {
      $(bb).text("Manage");
    }
  });
}

function set_button(user_id, value) {
  $('.manage-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manage', value);
    }
  });
  update_buttons();
}

function manage(user_id) {
  let text = JSON.stringify({
    manage: {
        manager_id: current_user_id,
        managee_id: user_id
      },
  });

  $.ajax(manage_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
  });
}

function unmanage(user_id, manage_id) {
  $.ajax(manage_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(user_id, ""); },
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('manage');
  let user_id = btn.data('user-id');

  if (manage_id != "") {
    unmanage(user_id, manage_id);
  }
  else {
    manage(user_id);
  }
}

function update_time_button() {
    $('.start-button').each( (_, bb) => {
        let task_id = $(bb).data('task-id');
        let started = $(bb).data('id');
        if (started!=null && started!="") {
            $(bb).text("Stop");
        }
        else {
            $(bb).text("Start");
        }
    });
}

function set_time_button(task_id, value) {
  $('.start-button').each( (_, bb) => {
    if (task_id == $(bb).data('task-id')) {
      $(bb).data('id', value);
    }
  });
    update_time_button();
}

function start_task(task_id, time) {
    let text = JSON.stringify({
        time_block: {
            task_id: task_id,
            start: time,
            started: true,
        },
    });
    console.log(text);
    $.ajax(time_block_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {set_time_button(task_id, resp.data.id); },
    });
}

function stop_task(task_id, time, id) {
  $.ajax(time_block_path + "/" + id, {
    method: "get",
    contentType: "application/json; charset=UTF-8",
    success: (resp) => { new_func(task_id, resp.data, time); }
  });
}

function new_func(task_id, data, time){
  let start = data.start;

   $.ajax(time_block_path + "/" + data.id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { after_delete(task_id, start, time);},
  });
}

function after_delete(task_id, start, time) {
  let text = JSON.stringify({
        time_block: {
            task_id: task_id,
            end_time: time,
	    start: start,
            started: false,
        },
    });
   console.log(text);
    $.ajax(time_block_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {set_time_button(task_id, ""); },
    });
}

function start_click(ev) {
    let btn = $(ev.target);
    let start = btn.data('id');
    let task_id = btn.data('task-id');
    let time = btn.data('time');
    if (start != ""){
        stop_task(task_id, time, start);
    }
    else{
        start_task(task_id, time);
    }
}

function init_manage() {
  if (!$('.manage-button')) {
    return;
  }

  $(".manage-button").click(manage_click);

  update_buttons();
}

function init_start() {
    if (!$('.start-button')) {
        return;
    }

    $(".start-button").click(start_click);
    update_time_button();
}


$(init_start);
$(init_manage);
