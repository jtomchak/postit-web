import CodeMirror from "codemirror/lib/codemirror";
import gfm from 'codemirror/mode/gfm/gfm'


const postEditor = CodeMirror.fromTextArea(document.getElementById('post_content'), {
  autofocus: true,
  lineWrapping: true,
  mode: {
    name: 'gfm',
  }
})

postEditor.on('update', () => {
  const postValue = postEditor.getValue();
  updateCharCountElement(postValue.length)
  updateWordCountElement(wordCount(postValue))
})

function wordCount(str) {
  return str.split(' ').filter(a => a.length > 0).length
}

function updateWordCountElement(wordCount) {
  document.querySelector("#word-count.level-item").textContent = wordCount;
}

function updateCharCountElement(charCount) {
  document.querySelector("#char-count.level-item").textContent = charCount;
}