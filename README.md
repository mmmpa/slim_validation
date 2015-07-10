[![Build Status](https://travis-ci.org/mmmpa/slim_validation.svg)](https://travis-ci.org/mmmpa/slim_validation)
[![Coverage Status](https://coveralls.io/repos/mmmpa/slim_validation/badge.svg?branch=master)](https://coveralls.io/r/mmmpa/slim_validation?branch=master)
[![Code Climate](https://codeclimate.com/github/mmmpa/slim_validation/badges/gpa.svg)](https://codeclimate.com/github/mmmpa/slim_validation)


# SlimValidation

`ActiveModel`や`ActiveRecord`用の`EachValidator`です。[slim-template/slim](https://github.com/slim-template/slim)のフォーマットにしたがってるか確認します。

`render`の成功をもってvalidとしているので、レンダリング結果をそのまま他のカラムに挿入出来ます。

```rb
class Entry < ActiveRecord::Base
	validates :slim,
	slim: {
		to: :html
	}
end
```

```rb
entry = Entry.new(slim: "h1 title\np catch copy")

entry.valid?
=> true

entry.html
=> "<h1>title</h1><p>catch copy</p>"
```

```rb
entry = Entry.new(slim: "  h1 title\np catch copy")

entry.valid?
=> false

entry.html
=> nil
```

# Installation

```rb
gem 'slim_validation'
```

```
bundle install
```

# Usage

|option|value||
|---|---|---|
|to|Procかattribute_name|レンダリング結果の挿入先、処理方法|
|options|Hash|Slim::Template.newにわたされるoptions|
|scope|:recordか任意のオブジェクト|slimのrender時に使う変数などの参照先|

```rb
validates :slim_proc,
	slim: {
		options: {pretty: false},
		to: ->(record, result) {
			record.html = result
		},
		allow_blank: true
	}
```

```rb
validates :slim_scope,
	slim: {
		options: {pretty: false},
		to: :html,
		scope: :record,
		allow_blank: true
	}
```
