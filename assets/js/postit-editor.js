import { EditorState, Plugin } from "prosemirror-state"
import { EditorView } from "prosemirror-view"
import { Schema, DOMParser } from "prosemirror-model"
import { schema as schemaBasic } from "prosemirror-schema-basic"
import { addListNodes } from "prosemirror-schema-list"
import { exampleSetup } from "prosemirror-example-setup"
import { schema, defaultMarkdownParser, defaultMarkdownSerializer } from "prosemirror-markdown"

// Mix the nodes from prosemirror-schema-list into the basic schema to
// create a schema with list support.
const mySchema = new Schema({
  nodes: addListNodes(schemaBasic.spec.nodes, "paragraph block*", "block"),
  marks: schemaBasic.spec.marks
})

let postitForm = document.querySelector("#postit-content-form")
let place = document.querySelector("#postit-md-wrapper")
let postContent = document.querySelector("#post_content")


class MarkdownView {
  constructor(target, content = "") {
    this.textarea = target.appendChild(document.createElement("textarea"))
    this.textarea.classList.add("ProseMirror");
    this.textarea.value = content
  }

  get content() { return this.textarea.value }
  focus() { this.textarea.focus() }
  destroy() { this.textarea.remove() }
}

// class ProseMirrorView {
//   constructor(target, content = "") {
//     this.view = new EditorView(target, {
//       state: EditorState.create({
//         doc: defaultMarkdownParser.parse(content),
//         plugins: exampleSetup({ schema, menuBar: false })
//       })
//     })
//   }

//   get content() {
//     console.log(this.view.state.doc)
//     return defaultMarkdownSerializer.serialize(this.view.state.doc)
//   }
//   focus() { this.view.focus() }
//   destroy() { this.view.destroy() }
// }


// let view = new ProseMirrorView(place)
let view = new MarkdownView(place, postContent.value)

// let countPlugin = new Plugin({
//   state: {
//     init() { return 0 },

//   }
// })

// let state = EditorState.create({
//   doc: defaultMarkdownParser.parse(""),
//   plugins: exampleSetup({ schema, menuBar: false })
// })
// let view = new EditorView(place, {
//   state
// })
window.view = view


function markdowSerializer(state) {
  return defaultMarkdownSerializer.serialize(state.doc);
}

function wordCount(str) {
  return str.split(' ').filter(a => a.length > 0).length
}

function updateWordCountElement(wordCount) {
  document.querySelector("#word-count.level-item").textContent = wordCount;
}

function updateCharCountElement(charCount) {
  document.querySelector("#char-count.level-item").textContent = charCount;
}

// capture form onSubmit and serialize content then **submit** form
postitForm.addEventListener('submit', function onSubmit(event) {
  event.preventDefault();
  console.log(view.content)
  postContent.value = view.content;
  postitForm.submit();
})
// Make focus on-load
view.focus();

