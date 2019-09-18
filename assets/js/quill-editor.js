
import "phoenix_html";
import Quill from 'quill/core';

import Toolbar from 'quill/modules/toolbar';
import Snow from 'quill/themes/snow';

import Bold from 'quill/formats/bold';
import Italic from 'quill/formats/italic';
import Header from 'quill/formats/header';
import Underline from 'quill/formats/underline'
import CodeBlock from 'quill/formats/code';


Quill.register({
  'modules/toolbar': Toolbar,
  'themes/snow': Snow,
  'formats/bold': Bold,
  'formats/italic': Italic,
  'formats/header': Header,
  'formats/underline': Underline,
  'formats/code': CodeBlock
});



document.addEventListener('DOMContentLoaded', init, false);
function init() {
  console.log("init....")
  btnPublish.addEventListener("click", publishPost);
}
console.log("loaded....")


var quill = new Quill('#post-editor', {
  modules: {
    toolbar: [
      [{ header: [1, 2, false] }],
      ['bold', 'italic', 'underline'],
      ['image', 'code-block']
    ]
  },
  placeholder: 'Thoughts ...',
  theme: 'snow'  // or 'bubble'
});

let btnPublish = document.getElementById("post-publish-btn")


const publishPost = event => {
  console.log();
  postContent(quill.getContents())
}

const postContent = p => {
  fetch('/api/v1/posts', {
    method: 'POST', // or 'PUT'
    body: JSON.stringify(p), // data can be `string` or {object}!
    headers: {
      'Content-Type': 'application/json'
    }
  }).then(res => res.json()).then(result => console.log(result)).catch(err => console.log(err))
}

