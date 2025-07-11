---
author: sean@getrubix.com
categories:
- design
date: Mon, 20 Apr 2018 04:20:00 +0000
description: >
  A simple design guide to follow for publishing new blogs and using our standard styles
slug: get-rubix-style-guide
tags:
- user interface
- webdesign
- style guide
thumbnail: https://getrubixsitecms.blob.core.windows.net/public-assets/content/v1/mardown-glass-tile-blog.png
title: Get Rubix Styling Showcase
---

## Welcome to the Markdown Styling Showcase

This guide demonstrates how various markdown elements are rendered and styled in our blog.

## Text & Headings

---

## Heading Level 2  
`## Large Heading`

### Heading Level 3  
`### Medium Heading`

#### Heading Level 4  
`#### Small Heading`

## Paragraphs & Text

This is a standard paragraph. You can use *italic*, **bold**, or even ***bold italic***.

`*italic*`, `**bold**`, `***bold italic***`

Here's a blockquote:

> Markdown makes writing content fast, but Tailwind makes it beautiful.

`> The thing you want to quote or emphasize`

## Lists

---

### Unordered List

- Item One  
- Item Two  
  - Nested Item  
- Item Three  

### Ordered List

This will give your numbered lists a distinct glassmorphism style with better indentation and legibility.

1. First step  
2. Second step  
3. Final step  

## Media

---

### Images

![Sample Image](https://placehold.co/600x200?text=Image+Preview)

Images will be rounded and responsive and come with a built-in image carousel if you click into them.

### Embedded Video

<div class="iframe-wrapper">
  <iframe src="https://www.youtube.com/embed/4y6u5OIn73g?feature=oembed" title="YouTube video player" frameborder="0" allowfullscreen></iframe>
</div>

This is how an embedded video will look. Use the following HTML block in your markdown to include a responsive YouTube embed:

```html
<div class="iframe-wrapper">
  <iframe src="https://www.youtube.com/embed/your-video-id" title="YouTube video player" frameborder="0" allowfullscreen></iframe>
</div>
```

---

## Links

---

You can link to [GetRubix](https://getrubix.com) or any external site. These links will open in a separate tab.

```markdown
[GetRubix](https://getrubix.com)
```

## Code

---

### Inline

Inline code: `npm install tailwindcss`

```ts
`inline code sample uses backticks`
```

### Code Block

```ts
export const helloWorld = () => {
  console.log("Hello, world!");
};
```
