/*!
 * jQuery Validation Plugin v1.14.0
 *
 * http://jqueryvalidation.org/
 *
 * Copyright (c) 2015 Jörn Zaefferer
 * Released under the MIT license
 */
!function(b) {
	"function" == typeof define && define.amd ? define([ "jquery" ], b) :b(jQuery);
}(function(e) {
	e.extend(e.fn, {
		validate:function(a) {
			if (!this.length) {
				return void (a && a.debug && window.console && console.warn("Nothing selected, can't validate, returning nothing."));
			}
			var g = e.data(this[0], "validator");
			return g ? g :(this.attr("novalidate", "novalidate"), g = new e.validator(a, this[0]),
				e.data(this[0], "validator", g), g.settings.onsubmit && (this.on("click.validate", ":submit", function(c) {
				g.settings.submitHandler && (g.submitButton = c.target), e(this).hasClass("cancel") && (g.cancelSubmit = !0),
				void 0 !== e(this).attr("formnovalidate") && (g.cancelSubmit = !0);
			}), this.on("submit.validate", function(c) {
				function h() {
					var i, b;
					return g.settings.submitHandler ? (g.submitButton && (i = e("<input type='hidden'/>").attr("name", g.submitButton.name).val(e(g.submitButton).val()).appendTo(g.currentForm)),
						b = g.settings.submitHandler.call(g, g.currentForm, c), g.submitButton && i.remove(),
						void 0 !== b ? b :!1) :!0;
				}
				return g.settings.debug && c.preventDefault(), g.cancelSubmit ? (g.cancelSubmit = !1,
					h()) :g.form() ? g.pendingRequest ? (g.formSubmitted = !0, !1) :h() :(g.focusInvalid(),
					!1);
			})), g);
		},
		valid:function() {
			var a, h, g;
			return e(this[0]).is("form") ? a = this.validate().form() :(g = [], a = !0, h = e(this[0].form).validate(),
				this.each(function() {
					a = h.element(this) && a, g = g.concat(h.errorList);
				}), h.errorList = g), a;
		},
		rules:function(r, q) {
			var p, o, n, m, l, k, a = this[0];
			if (r) {
				switch (p = e.data(a.form, "validator").settings, o = p.rules, n = e.validator.staticRules(a),
					r) {
					case "add":
						e.extend(n, e.validator.normalizeRule(q)), delete n.messages, o[a.name] = n, q.messages && (p.messages[a.name] = e.extend(p.messages[a.name], q.messages));
						break;

					case "remove":
						return q ? (k = {}, e.each(q.split(/\s/), function(g, h) {
							k[h] = n[h], delete n[h], "required" === h && e(a).removeAttr("aria-required");
						}), k) :(delete o[a.name], n);
				}
			}
			return m = e.validator.normalizeRules(e.extend({}, e.validator.classRules(a), e.validator.attributeRules(a), e.validator.dataRules(a), e.validator.staticRules(a)), a),
			m.required && (l = m.required, delete m.required, m = e.extend({
				required:l
			}, m), e(a).attr("aria-required", "true")), m.remote && (l = m.remote, delete m.remote,
				m = e.extend(m, {
					remote:l
				})), m;
		}
	}), e.extend(e.expr[":"], {
		blank:function(a) {
			return !e.trim("" + e(a).val());
		},
		filled:function(a) {
			return !!e.trim("" + e(a).val());
		},
		unchecked:function(a) {
			return !e(a).prop("checked");
		}
	}), e.validator = function(a, g) {
		this.settings = e.extend(!0, {}, e.validator.defaults, a), this.currentForm = g,
			this.init();
	}, e.validator.format = function(a, g) {
		return 1 === arguments.length ? function() {
			var b = e.makeArray(arguments);
			return b.unshift(a), e.validator.format.apply(this, b);
		} :(arguments.length > 2 && g.constructor !== Array && (g = e.makeArray(arguments).slice(1)),
		g.constructor !== Array && (g = [ g ]), e.each(g, function(b, h) {
			a = a.replace(new RegExp("\\{" + b + "\\}", "g"), function() {
				return h;
			});
		}), a);
	}, e.extend(e.validator, {
		defaults:{
			messages:{},
			groups:{},
			rules:{},
			errorClass:"error",
			validClass:"valid",
			errorElement:"label",
			focusCleanup:!1,
			focusInvalid:!0,
			errorContainer:e([]),
			errorLabelContainer:e([]),
			onsubmit:!0,
			ignore:":hidden",
			ignoreTitle:!1,
			onfocusin:function(b) {
				this.lastActive = b, this.settings.focusCleanup && (this.settings.unhighlight && this.settings.unhighlight.call(this, b, this.settings.errorClass, this.settings.validClass),
					this.hideThese(this.errorsFor(b)));
			},
			onfocusout:function(b) {
				this.checkable(b) || !(b.name in this.submitted) && this.optional(b) || this.element(b);
			},
			onkeyup:function(a, h) {
				var g = [ 16, 17, 18, 20, 35, 36, 37, 38, 39, 40, 45, 144, 225 ];
				9 === h.which && "" === this.elementValue(a) || -1 !== e.inArray(h.keyCode, g) || (a.name in this.submitted || a === this.lastElement) && this.element(a);
			},
			onclick:function(b) {
				b.name in this.submitted ? this.element(b) :b.parentNode.name in this.submitted && this.element(b.parentNode);
			},
			highlight:function(a, h, g) {
				"radio" === a.type ? this.findByName(a.name).addClass(h).removeClass(g) :e(a).addClass(h).removeClass(g);
			},
			unhighlight:function(a, h, g) {
				"radio" === a.type ? this.findByName(a.name).removeClass(h).addClass(g) :e(a).removeClass(h).addClass(g);
			}
		},
		setDefaults:function(a) {
			e.extend(e.validator.defaults, a);
		},
		messages:{
			required:"This field is required.",
			remote:"Please fix this field.",
			email:"Please enter a valid email address.",
			url:"Please enter a valid URL.",
			date:"Please enter a valid date.",
			dateISO:"Please enter a valid date ( ISO ).",
			number:"Please enter a valid number.",
			digits:"Please enter only digits.",
			creditcard:"Please enter a valid credit card number.",
			equalTo:"Please enter the same value again.",
			maxlength:e.validator.format("Please enter no more than {0} characters."),
			minlength:e.validator.format("Please enter at least {0} characters."),
			rangelength:e.validator.format("Please enter a value between {0} and {1} characters long."),
			range:e.validator.format("Please enter a value between {0} and {1}."),
			max:e.validator.format("Please enter a value less than or equal to {0}."),
			min:e.validator.format("Please enter a value greater than or equal to {0}.")
		},
		autoCreateRanges:!1,
		prototype:{
			init:function() {
				function a(i) {
					var l = e.data(this.form, "validator"), k = "on" + i.type.replace(/^validate/, ""), j = l.settings;
					j[k] && !e(this).is(j.ignore) && j[k].call(l, this, i);
				}
				this.labelContainer = e(this.settings.errorLabelContainer), this.errorContext = this.labelContainer.length && this.labelContainer || e(this.currentForm),
					this.containers = e(this.settings.errorContainer).add(this.settings.errorLabelContainer),
					this.submitted = {}, this.valueCache = {}, this.pendingRequest = 0, this.pending = {},
					this.invalid = {}, this.reset();
				var h, g = this.groups = {};
				e.each(this.settings.groups, function(i, j) {
					"string" == typeof j && (j = j.split(/\s/)), e.each(j, function(b, k) {
						g[k] = i;
					});
				}), h = this.settings.rules, e.each(h, function(c, i) {
					h[c] = e.validator.normalizeRule(i);
				}), e(this.currentForm).on("focusin.validate focusout.validate keyup.validate", ":text, [type='password'], [type='file'], select, textarea, [type='number'], [type='search'], [type='tel'], [type='url'], [type='email'], [type='datetime'], [type='date'], [type='month'], [type='week'], [type='time'], [type='datetime-local'], [type='range'], [type='color'], [type='radio'], [type='checkbox']", a).on("click.validate", "select, option, [type='radio'], [type='checkbox']", a),
				this.settings.invalidHandler && e(this.currentForm).on("invalid-form.validate", this.settings.invalidHandler),
					e(this.currentForm).find("[required], [data-rule-required], .required").attr("aria-required", "true");
			},
			form:function() {
				return this.checkForm(), e.extend(this.submitted, this.errorMap), this.invalid = e.extend({}, this.errorMap),
				this.valid() || e(this.currentForm).triggerHandler("invalid-form", [ this ]), this.showErrors(),
					this.valid();
			},
			checkForm:function() {
				this.prepareForm();
				for (var g = 0, c = this.currentElements = this.elements(); c[g]; g++) {
					this.check(c[g]);
				}
				return this.valid();
			},
			element:function(a) {
				var i = this.clean(a), h = this.validationTargetFor(i), g = !0;
				return this.lastElement = h, void 0 === h ? delete this.invalid[i.name] :(this.prepareElement(h),
					this.currentElements = e(h), g = this.check(h) !== !1, g ? delete this.invalid[h.name] :this.invalid[h.name] = !0),
					e(a).attr("aria-invalid", !g), this.numberOfInvalids() || (this.toHide = this.toHide.add(this.containers)),
					this.showErrors(), g;
			},
			showErrors:function(a) {
				if (a) {
					e.extend(this.errorMap, a), this.errorList = [];
					for (var g in a) {
						this.errorList.push({
							message:a[g],
							element:this.findByName(g)[0]
						});
					}
					this.successList = e.grep(this.successList, function(b) {
						return !(b.name in a);
					});
				}
				this.settings.showErrors ? this.settings.showErrors.call(this, this.errorMap, this.errorList) :this.defaultShowErrors();
			},
			resetForm:function() {
				e.fn.resetForm && e(this.currentForm).resetForm(), this.submitted = {}, this.lastElement = null,
					this.prepareForm(), this.hideErrors();
				var a, g = this.elements().removeData("previousValue").removeAttr("aria-invalid");
				if (this.settings.unhighlight) {
					for (a = 0; g[a]; a++) {
						this.settings.unhighlight.call(this, g[a], this.settings.errorClass, "");
					}
				} else {
					g.removeClass(this.settings.errorClass);
				}
			},
			numberOfInvalids:function() {
				return this.objectLength(this.invalid);
			},
			objectLength:function(h) {
				var g, i = 0;
				for (g in h) {
					i++;
				}
				return i;
			},
			hideErrors:function() {
				this.hideThese(this.toHide);
			},
			hideThese:function(b) {
				b.not(this.containers).text(""), this.addWrapper(b).hide();
			},
			valid:function() {
				return 0 === this.size();
			},
			size:function() {
				return this.errorList.length;
			},
			focusInvalid:function() {
				if (this.settings.focusInvalid) {
					try {
						e(this.findLastActive() || this.errorList.length && this.errorList[0].element || []).filter(":visible").focus().trigger("focusin");
					} catch (a) {}
				}
			},
			findLastActive:function() {
				var a = this.lastActive;
				return a && 1 === e.grep(this.errorList, function(b) {
						return b.element.name === a.name;
					}).length && a;
			},
			elements:function() {
				var g = this, c = {};
				return $(this.currentForm).find("input, select, textarea").not(":submit, :reset, :image, [disabled], [readonly]").not(this.settings.ignore).filter(function() {
					if (!this.name && g.settings.debug && window.console && console.error("%o has no name assigned", this),
							this.id) {
						if (!g.objectLength($(this).rules())) {
							return !1;
						}
					} else {
						if (this.name in c || !g.objectLength($(this).rules())) {
							return !1;
						}
						c[this.name] = !0;
					}
					return !0;
				});
			},
			clean:function(a) {
				return e(a)[0];
			},
			errors:function() {
				var a = this.settings.errorClass.split(" ").join(".");
				return e(this.settings.errorElement + "." + a, this.errorContext);
			},
			reset:function() {
				this.successList = [], this.errorList = [], this.errorMap = {}, this.toShow = e([]),
					this.toHide = e([]), this.currentElements = e([]);
			},
			prepareForm:function() {
				this.reset(), this.toHide = this.errors().add(this.containers);
			},
			prepareElement:function(b) {
				this.reset(), this.toHide = this.errorsFor(b);
			},
			elementValue:function(a) {
				var i, h = e(a), g = a.type;
				return "radio" === g || "checkbox" === g ? this.findByName(a.name).filter(":checked").val() :"number" === g && "undefined" != typeof a.validity ? a.validity.badInput ? !1 :h.val() :(i = h.val(),
					"string" == typeof i ? i.replace(/\r/g, "") :i);
			},
			check:function(r) {
				r = this.validationTargetFor(this.clean(r));
				var q, p, o, n = e(r).rules(), m = e.map(n, function(g, c) {
					return c;
				}).length, l = !1, k = this.elementValue(r);
				for (p in n) {
					o = {
						method:p,
						parameters:n[p]
					};
					try {
						if (q = e.validator.methods[p].call(this, k, r, o.parameters), "dependency-mismatch" === q && 1 === m) {
							l = !0;
							continue;
						}
						if (l = !1, "pending" === q) {
							return void (this.toHide = this.toHide.not(this.errorsFor(r)));
						}
						if (!q) {
							return this.formatAndAdd(r, o), !1;
						}
					} catch (a) {
						throw this.settings.debug && window.console && console.log("Exception occurred when checking element " + r.id + ", check the '" + o.method + "' method.", a),
						a instanceof TypeError && (a.message += ".  Exception occurred when checking element " + r.id + ", check the '" + o.method + "' method."),
							a;
					}
				}
				return l ? void 0 :(this.objectLength(n) && this.successList.push(r), !0);
			},
			customDataMessage:function(a, g) {
				return e(a).data("msg" + g.charAt(0).toUpperCase() + g.substring(1).toLowerCase()) || e(a).data("msg");
			},
			customMessage:function(h, g) {
				var i = this.settings.messages[h];
				return i && (i.constructor === String ? i :i[g]);
			},
			findDefined:function() {
				for (var b = 0; b < arguments.length; b++) {
					if (void 0 !== arguments[b]) {
						return arguments[b];
					}
				}
				return void 0;
			},
			defaultMessage:function(a, g) {
				return this.findDefined(this.customMessage(a.name, g), this.customDataMessage(a, g), !this.settings.ignoreTitle && a.title || void 0, e.validator.messages[g], "<strong>Warning: No message defined for " + a.name + "</strong>");
			},
			formatAndAdd:function(a, i) {
				var h = this.defaultMessage(a, i.method), g = /\$?\{(\d+)\}/g;
				"function" == typeof h ? h = h.call(this, i.parameters, a) :g.test(h) && (h = e.validator.format(h.replace(g, "{$1}"), i.parameters)),
					this.errorList.push({
						message:h,
						element:a,
						method:i.method
					}), this.errorMap[a.name] = h, this.submitted[a.name] = h;
			},
			addWrapper:function(b) {
				return this.settings.wrapper && (b = b.add(b.parent(this.settings.wrapper))), b;
			},
			defaultShowErrors:function() {
				var h, g, i;
				for (h = 0; this.errorList[h]; h++) {
					i = this.errorList[h], this.settings.highlight && this.settings.highlight.call(this, i.element, this.settings.errorClass, this.settings.validClass),
						this.showLabel(i.element, i.message);
				}
				if (this.errorList.length && (this.toShow = this.toShow.add(this.containers)), this.settings.success) {
					for (h = 0; this.successList[h]; h++) {
						this.showLabel(this.successList[h]);
					}
				}
				if (this.settings.unhighlight) {
					for (h = 0, g = this.validElements(); g[h]; h++) {
						this.settings.unhighlight.call(this, g[h], this.settings.errorClass, this.settings.validClass);
					}
				}
				this.toHide = this.toHide.not(this.toShow), this.hideErrors(), this.addWrapper(this.toShow).show();
			},
			validElements:function() {
				return this.currentElements.not(this.invalidElements());
			},
			invalidElements:function() {
				return e(this.errorList).map(function() {
					return this.element;
				});
			},
			showLabel:function(a, p) {
				var o, n, m, l = this.errorsFor(a), k = this.idOrName(a), j = e(a).attr("aria-describedby");
				l.length ? (l.removeClass(this.settings.validClass).addClass(this.settings.errorClass),
					l.html(p)) :(l = e("<" + this.settings.errorElement + ">").attr("id", k + "-error").addClass(this.settings.errorClass).html(p || ""),
					o = l, this.settings.wrapper && (o = l.hide().show().wrap("<" + this.settings.wrapper + "/>").parent()),
					this.labelContainer.length ? this.labelContainer.append(o) :this.settings.errorPlacement ? this.settings.errorPlacement(o, e(a)) :o.insertAfter(a),
					l.is("label") ? l.attr("for", k) :0 === l.parents("label[for='" + k + "']").length && (m = l.attr("id").replace(/(:|\.|\[|\]|\$)/g, "\\$1"),
						j ? j.match(new RegExp("\\b" + m + "\\b")) || (j += " " + m) :j = m, e(a).attr("aria-describedby", j),
						n = this.groups[a.name], n && e.each(this.groups, function(g, h) {
						h === n && e("[name='" + g + "']", this.currentForm).attr("aria-describedby", l.attr("id"));
					}))), !p && this.settings.success && (l.text(""), "string" == typeof this.settings.success ? l.addClass(this.settings.success) :this.settings.success(l, a)),
					this.toShow = this.toShow.add(l);
			},
			errorsFor:function(a) {
				var i = this.idOrName(a), h = e(a).attr("aria-describedby"), g = "label[for='" + i + "'], label[for='" + i + "'] *";
				return h && (g = g + ", #" + h.replace(/\s+/g, ", #")), this.errors().filter(g);
			},
			idOrName:function(b) {
				return this.groups[b.name] || (this.checkable(b) ? b.name :b.id || b.name);
			},
			validationTargetFor:function(a) {
				return this.checkable(a) && (a = this.findByName(a.name)), e(a).not(this.settings.ignore)[0];
			},
			checkable:function(b) {
				return /radio|checkbox/i.test(b.type);
			},
			findByName:function(a) {
				return e(this.currentForm).find("[name='" + a + "']");
			},
			getLength:function(a, g) {
				switch (g.nodeName.toLowerCase()) {
					case "select":
						return e("option:selected", g).length;

					case "input":
						if (this.checkable(g)) {
							return this.findByName(g.name).filter(":checked").length;
						}
				}
				return a.length;
			},
			depend:function(g, c) {
				return this.dependTypes[typeof g] ? this.dependTypes[typeof g](g, c) :!0;
			},
			dependTypes:{
				"boolean":function(b) {
					return b;
				},
				string:function(a, g) {
					return !!e(a, g.form).length;
				},
				"function":function(g, c) {
					return g(c);
				}
			},
			optional:function(a) {
				var g = this.elementValue(a);
				return !e.validator.methods.required.call(this, g, a) && "dependency-mismatch";
			},
			startRequest:function(b) {
				this.pending[b.name] || (this.pendingRequest++, this.pending[b.name] = !0);
			},
			stopRequest:function(a, g) {
				this.pendingRequest--, this.pendingRequest < 0 && (this.pendingRequest = 0), delete this.pending[a.name],
					g && 0 === this.pendingRequest && this.formSubmitted && this.form() ? (e(this.currentForm).submit(),
						this.formSubmitted = !1) :!g && 0 === this.pendingRequest && this.formSubmitted && (e(this.currentForm).triggerHandler("invalid-form", [ this ]),
						this.formSubmitted = !1);
			},
			previousValue:function(a) {
				return e.data(a, "previousValue") || e.data(a, "previousValue", {
						old:null,
						valid:!0,
						message:this.defaultMessage(a, "remote")
					});
			},
			destroy:function() {
				this.resetForm(), e(this.currentForm).off(".validate").removeData("validator");
			}
		},
		classRuleSettings:{
			required:{
				required:!0
			},
			email:{
				email:!0
			},
			url:{
				url:!0
			},
			date:{
				date:!0
			},
			dateISO:{
				dateISO:!0
			},
			number:{
				number:!0
			},
			digits:{
				digits:!0
			},
			creditcard:{
				creditcard:!0
			}
		},
		addClassRules:function(a, g) {
			a.constructor === String ? this.classRuleSettings[a] = g :e.extend(this.classRuleSettings, a);
		},
		classRules:function(a) {
			var h = {}, g = e(a).attr("class");
			return g && e.each(g.split(" "), function() {
				this in e.validator.classRuleSettings && e.extend(h, e.validator.classRuleSettings[this]);
			}), h;
		},
		normalizeAttributeRule:function(h, g, j, i) {
			/min|max/.test(j) && (null === g || /number|range|text/.test(g)) && (i = Number(i),
			isNaN(i) && (i = void 0)), i || 0 === i ? h[j] = i :g === j && "range" !== g && (h[j] = !0);
		},
		attributeRules:function(a) {
			var l, k, j = {}, i = e(a), h = a.getAttribute("type");
			for (l in e.validator.methods) {
				"required" === l ? (k = a.getAttribute(l), "" === k && (k = !0), k = !!k) :k = i.attr(l),
					this.normalizeAttributeRule(j, h, l, k);
			}
			return j.maxlength && /-1|2147483647|524288/.test(j.maxlength) && delete j.maxlength,
				j;
		},
		dataRules:function(a) {
			var l, k, j = {}, i = e(a), h = a.getAttribute("type");
			for (l in e.validator.methods) {
				k = i.data("rule" + l.charAt(0).toUpperCase() + l.substring(1).toLowerCase()), this.normalizeAttributeRule(j, h, l, k);
			}
			return j;
		},
		staticRules:function(a) {
			var h = {}, g = e.data(a.form, "validator");
			return g.settings.rules && (h = e.validator.normalizeRule(g.settings.rules[a.name]) || {}),
				h;
		},
		normalizeRules:function(a, g) {
			return e.each(a, function(h, c) {
				if (c === !1) {
					return void delete a[h];
				}
				if (c.param || c.depends) {
					var b = !0;
					switch (typeof c.depends) {
						case "string":
							b = !!e(c.depends, g.form).length;
							break;

						case "function":
							b = c.depends.call(g, g);
					}
					b ? a[h] = void 0 !== c.param ? c.param :!0 :delete a[h];
				}
			}), e.each(a, function(c, b) {
				a[c] = e.isFunction(b) ? b(g) :b;
			}), e.each([ "minlength", "maxlength" ], function() {
				a[this] && (a[this] = Number(a[this]));
			}), e.each([ "rangelength", "range" ], function() {
				var b;
				a[this] && (e.isArray(a[this]) ? a[this] = [ Number(a[this][0]), Number(a[this][1]) ] :"string" == typeof a[this] && (b = a[this].replace(/[\[\]]/g, "").split(/[\s,]+/),
					a[this] = [ Number(b[0]), Number(b[1]) ]));
			}), e.validator.autoCreateRanges && (null != a.min && null != a.max && (a.range = [ a.min, a.max ],
				delete a.min, delete a.max), null != a.minlength && null != a.maxlength && (a.rangelength = [ a.minlength, a.maxlength ],
				delete a.minlength, delete a.maxlength)), a;
		},
		normalizeRule:function(a) {
			if ("string" == typeof a) {
				var g = {};
				e.each(a.split(/\s/), function() {
					g[this] = !0;
				}), a = g;
			}
			return a;
		},
		addMethod:function(a, h, g) {
			e.validator.methods[a] = h, e.validator.messages[a] = void 0 !== g ? g :e.validator.messages[a],
			h.length < 3 && e.validator.addClassRules(a, e.validator.normalizeRule(a));
		},
		methods:{
			required:function(a, i, h) {
				if (!this.depend(h, i)) {
					return "dependency-mismatch";
				}
				if ("select" === i.nodeName.toLowerCase()) {
					var g = e(i).val();
					return g && g.length > 0;
				}
				return this.checkable(i) ? this.getLength(a, i) > 0 :a.length > 0;
			},
			email:function(g, c) {
				return this.optional(c) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test(g);
			},
			url:function(g, c) {
				return this.optional(c) || /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(g);
			},
			date:function(g, c) {
				return this.optional(c) || !/Invalid|NaN/.test(new Date(g).toString());
			},
			dateISO:function(g, c) {
				return this.optional(c) || /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/.test(g);
			},
			number:function(g, c) {
				return this.optional(c) || /^(?:-?\d+|-?\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(g);
			},
			digits:function(g, c) {
				return this.optional(c) || /^\d+$/.test(g);
			},
			creditcard:function(i, h) {
				if (this.optional(h)) {
					return "dependency-mismatch";
				}
				if (/[^0-9 \-]+/.test(i)) {
					return !1;
				}
				var n, m, l = 0, k = 0, j = !1;
				if (i = i.replace(/\D/g, ""), i.length < 13 || i.length > 19) {
					return !1;
				}
				for (n = i.length - 1; n >= 0; n--) {
					m = i.charAt(n), k = parseInt(m, 10), j && (k *= 2) > 9 && (k -= 9), l += k, j = !j;
				}
				return 0 === l % 10;
			},
			minlength:function(a, i, h) {
				var g = e.isArray(a) ? a.length :this.getLength(a, i);
				return this.optional(i) || g >= h;
			},
			maxlength:function(a, i, h) {
				var g = e.isArray(a) ? a.length :this.getLength(a, i);
				return this.optional(i) || h >= g;
			},
			rangelength:function(a, i, h) {
				var g = e.isArray(a) ? a.length :this.getLength(a, i);
				return this.optional(i) || g >= h[0] && g <= h[1];
			},
			min:function(h, g, i) {
				return this.optional(g) || h >= i;
			},
			max:function(h, g, i) {
				return this.optional(g) || i >= h;
			},
			range:function(h, g, i) {
				return this.optional(g) || h >= i[0] && h <= i[1];
			},
			equalTo:function(a, i, h) {
				var g = e(h);
				return this.settings.onfocusout && g.off(".validate-equalTo").on("blur.validate-equalTo", function() {
					e(i).valid();
				}), a === g.val();
			},
			remote:function(a, l, k) {
				if (this.optional(l)) {
					return "dependency-mismatch";
				}
				var j, i, h = this.previousValue(l);
				return this.settings.messages[l.name] || (this.settings.messages[l.name] = {}),
					h.originalMessage = this.settings.messages[l.name].remote, this.settings.messages[l.name].remote = h.message,
					k = "string" == typeof k && {
							url:k
						} || k, h.old === a ? h.valid :(h.old = a, j = this, this.startRequest(l), i = {},
					i[l.name] = a, e.ajax(e.extend(!0, {
					mode:"abort",
					port:"validate" + l.name,
					dataType:"json",
					data:i,
					context:j.currentForm,
					success:function(n) {
						var m, g, c, b = n === !0 || "true" === n;
						j.settings.messages[l.name].remote = h.originalMessage, b ? (c = j.formSubmitted,
							j.prepareElement(l), j.formSubmitted = c, j.successList.push(l), delete j.invalid[l.name],
							j.showErrors()) :(m = {}, g = n || j.defaultMessage(l, "remote"), m[l.name] = h.message = e.isFunction(g) ? g(a) :g,
							j.invalid[l.name] = !0, j.showErrors(m)), h.valid = b, j.stopRequest(l, b);
					}
				}, k)), "pending");
			}
		}
	});
	var d, f = {};
	e.ajaxPrefilter ? e.ajaxPrefilter(function(g, c, i) {
		var h = g.port;
		"abort" === g.mode && (f[h] && f[h].abort(), f[h] = i);
	}) :(d = e.ajax, e.ajax = function(c) {
		var b = ("mode" in c ? c :e.ajaxSettings).mode, a = ("port" in c ? c :e.ajaxSettings).port;
		return "abort" === b ? (f[a] && f[a].abort(), f[a] = d.apply(this, arguments), f[a]) :d.apply(this, arguments);
	});
});