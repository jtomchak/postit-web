import { EditorState, Plugin } from "prosemirror-state"
import { EditorView } from "prosemirror-view"
import { Schema, DOMParser } from "prosemirror-model"
import { schema as schemaBasic } from "prosemirror-schema-basic"
import { addListNodes } from "prosemirror-schema-list"
import { exampleSetup } from "prosemirror-example-setup"
import { coreSetup } from "./prosemirror"
import { schema, defaultMarkdownParser, defaultMarkdownSerializer } from "prosemirror-markdown"

let postitForm = document.querySelector("#postit-content-form")
let place = document.querySelector("#postit-md-wrapper")
let postContent = document.querySelector("#post_content")


class ProseMirrorView {
  constructor(target, content = "") {
    this.view = new EditorView(target, {
      state: EditorState.create({
        doc: defaultMarkdownParser.parse(content),
        plugins: coreSetup({ schema, menuBar: false })
      }),
      dispatchTransaction: dispatchTransaction
    })

  }

  get content() {
    // return defaultMarkdownSerializer.serialize(this.view.state.doc)
    return defaultMarkdownSerializer.serialize(this.view.state.doc)
  }
  focus() { this.view.focus() }
  destroy() { this.view.destroy() }
}
const dispatchTransaction = (transaction) => {
  // Update state
  let newState = view.view.state.apply(transaction)
  view.view.updateState(newState)

  // run effects
  calculateWordCount(newState)
  calculateCharCount(newState)
}

let view = new ProseMirrorView(place)

const calculateWordCount = state => {
  const content = markdowSerializer(state.doc);
  //update dom
  updateWordCountElement(wordCount(content))
}

const calculateCharCount = state => {
  const content = markdowSerializer(state.doc)
  updateCharCountElement(content.length)
}

function markdowSerializer(doc) {
  return defaultMarkdownSerializer.serialize(doc);
}

function wordCount(str) {
  return str.split(' ').filter(a => a.length > 0).length
}

function updateWordCountElement(wordCount = 0) {
  document.querySelector("#word-count").textContent = `w ${wordCount}`;
}

function updateCharCountElement(charCount = 0) {
  let charElement = document.querySelector("#char-count");
  if (charCount > 280) {
    charElement.style.color = "red";
  } else {
    charElement.style.color = "black";
  }
  charElement.textContent = `${charCount}`;
}

// capture form onSubmit and serialize content then **submit** form
postitForm.addEventListener('submit', function onSubmit(event) {
  event.preventDefault();
  console.log(view.content)
  postContent.value = view.content;
  // postitForm.submit();
})
// Make focus on-load
view.focus();
updateCharCountElement();
updateWordCountElement();

