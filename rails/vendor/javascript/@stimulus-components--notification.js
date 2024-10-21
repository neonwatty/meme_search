// @stimulus-components/notification@3.0.0 downloaded from https://ga.jspm.io/npm:@stimulus-components/notification@3.0.0/dist/stimulus-notification.mjs

import{Controller as t}from"@hotwired/stimulus";import{useTransition as e}from"stimulus-use";const i=class _Notification extends t{initialize(){this.hide=this.hide.bind(this)}connect(){e(this),this.hiddenValue===!1&&this.show()}show(){this.enter(),this.timeout=setTimeout(this.hide,this.delayValue)}async hide(){this.timeout&&clearTimeout(this.timeout),await this.leave(),this.element.remove()}};i.values={delay:{type:Number,default:3e3},hidden:{type:Boolean,default:!1}};let s=i;export{s as default};

