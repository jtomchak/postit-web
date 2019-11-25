import { EditorState } from "prosemirror-state"
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
console.log(postitForm)
class MarkdownView {
  constructor(target, content = "") {
    this.textarea = target
    this.textarea.value = content;
  }

  get content() { return this.textarea.value }
  focus() { this.textarea.focus() }
  destroy() { this.textarea.remove() }
}

class ProseMirrorView {
  constructor(target, content = "") {
    this.view = new EditorView(target, {
      state: EditorState.create({
        doc: defaultMarkdownParser.parse(content),
        plugins: exampleSetup({ schema })
      })
    })
  }

  get content() {
    return defaultMarkdownSerializer.serialize(this.view.state.doc)
  }
  focus() { this.view.focus() }
  destroy() { this.view.destroy() }
}


let view = new ProseMirrorView(place)
window.view = view

// capture form onSubmit and serialize content then **submit** form
postitForm.addEventListener('submit', function onSubmit(event) {
  event.preventDefault();
  postContent.value = view.content
  postitForm.submit();
})
view.focus();

