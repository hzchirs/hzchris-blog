// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require ahoy
//= require foundation
//require bootstrap-sprockets
//require bootstrap-material-design
//= require nprogress
//= require config
//= require react
//= require react_ujs
//= require components
//= require jquery.autosize
//= require_tree .

window.marked = require('marked')
marked.setOptions({
  sanitize: true,
  gfm: true,
  breaks: true
})

window.removeMd = require('remove-markdown')

$(function(){ $(document).foundation(); });
