# CSS

- CSS - Cascading Style Sheets / 웹 페이지를 디자인 하기 위해 인터넷에서 사용되는 언어
- 텍스트의 정렬, 다양한 요소의 크기나 색, 창의 크기가 조정될 때 HTML요소가 어떻게 나타날 지 등을 결정합니다.

<br>

<br>

## Style 속성

- CSS는 HTML의 요소 태그 안에 style 속성으로 사용할 수 있습니다.
- CSS는 속성과 값이 한 쌍을 이루어 사용되며, 각각의 CSS 속성 뒤에는 콜론(:)과 그 값이 옵니다.
- 여러 속성-값 쌍인 경우 세미콜론(;)으로 분리합니다.

```css
<p style="font-size:28px;">
	This is a paratraph.
</p>
```

- style은 HTML 속성의 이름입니다.
- font-size는 CSS 속성의 예입니다.
  - CSS 속성에는 color(텍스트 색), text-align(텍스트 정렬), font(텍스트 글꼴)가 있습니다.

<br>

<br>

## Style 태그

- CSS는 style의 내부에 위치할 수 있습니다.

```css
<!DOCTYPE html>
<html>
	<head>
		<title>Page</title>
		<style>
			p
			{
				font-size:28px;
			}
		</style>
	</head>
	<body>
		<p>This is a paragraph.</p>
	</body>
</html>
```

- style태그 안에 요소의 이름, id, class등을 사용해서 무엇에 스타일을 적용할 것인지를 명시해야 합니다.
- 스타일을 어디에 적용할 지 결정한 후에는 CSS 속성 - 값 쌍은 괄호 {}안에서 세미콜론(;)으로 분리해 포함시킬 수 있습니다.
- 이런 방식을 사용하면 같은 HTML 요소를 여러 번 사용하였을때, 동일한 CSS를 반복 적용할 필요가 없습니다.

<br>

<br>

## 분리된 CSS

- CSS로 스타일을 지저하는 방법중에 하나로 분리된 파일에 CSS를 저장해 놓고 사용하는 방법입니다.
- style 태그 안의 내용을 문서로 저장하면 일반적으로 .css 형태의 파일이 생성됩니다.
- 만들어진 CSS파일을 HTML 문서 안으로 불러와 HTML 문서의 head 요소에 `<link>` 태그에 포함하면 CSS가 적용이 됩니다.
- `<link href="style.css" rel="stylesheet" />` 와 같은 줄을 포함하면 외부의 CSS 문서가 HTML 문서에 추가되어 적절한 스타일이 나타날 것입니다.
- CSS를 분리된 문서로 만드는 것은 서로 다른 HTML 문서들이 같은 스타일을 사용할 때 유용합니다.