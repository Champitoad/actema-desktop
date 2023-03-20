<style lang="scss">

.pi-btn:focus,
.pi-btn:active {
    outline: none !important;
}

:focus,
.btn:focus {
    outline: none !important;
}

.pi-btn {
    /* border-radius: 2px!important; */
    opacity: 0.8;
    font-weight: bold;
    border-width: 2px;
    line-height: 1.2em;
    z-index: 1;
    padding-top: 2px !important;
    padding-bottom: 2px !important;
    padding-left: 4px !important;
    padding-right: 4px !important;
}

.pi-btn>span {
    /* we want the padding to be applied on the MathJax container so the content is full-size */
    padding: 0px 8px !important;
}

.pi-btn:hover {
    z-index: 2;
}

.pi-btn span {
    line-height: 1.6em;
    display: inline-block;
    font-size: 20px;
    font-family: "Computer Modern Sans", sans-serif;
    height: 100%;
    padding-left: 0.1em;
    padding-right: 0.1em;
    border-radius: 0px !important;
}

.pi-btn:hover>span span.action {
    background-color: rgb(255,200,150);
//    background-color: orange;
}

.pi-btn.dragged:hover>span span.action {
    background-color: inherit;
}

.pi-btn .MJX-TEX,
.pi-btn math {
    padding: .375rem .75rem;
}

.splittable {
    font-weight: bold;
}

.pi-btn:hover {
    /* background-color: inherit!important;
    color: inherit!important;*/
    opacity: 1;
}

.pi-btn:hover span.splittable {
    color: #612521;
    /* opacity: 1; */
}

.pi-btn span.splittable {
    font-weight: bold;
}

.pi-btn span.splittable:hover {
    color: red;
}

span.MathJax {
    width: 100%;
    height: 100%;
    display: block;
    overflow: hidden;
}

.math {
    padding-top: 5px;
    padding-bottom: 5px;
    padding-left: 2px;
    padding-right: 2px;
}


$btn-duration: 0.25s;
$btn-duration-total: ($btn-duration * 4) * 2;
.pi-btn.pi-goal.loading {
    &::before,
    &::after,
    span::before,
    span::after {
        background: #dc3545;
    }
}

.pi-btn.predicate.loading {
    &::before,
    &::after,
    span::before,
    span::after {
        background: #007bff;
    }
}

.pi-btn.expression.loading {
    &::before,
    &::after,
    span::before,
    span::after {
        background: #00ff00;
    }
    &::before {
        right: 0;
        top: 0;
    }
    &::after {
        bottom: 0;
        left: 0;
    }
}

.pi-btn {
    white-space: nowrap;
    box-shadow: 1px 2px 2px #aaa;
    border-radius: 0px;
    background-color: white;
}

.pi-btn.displaying-highlight {
    padding-top: 0px !important;
    padding-bottom: 0px !important;
}

.pi-btn:hover {
    box-shadow: 2px 4px 4px #aaa;
}

.pi-btn.dragged {
    z-index: 5;
}

.pi-btn span {
    padding-left: 0px;
    padding-right: 0px;
}

// .pi-btn.select-mode > span span[id]:hover {
//     background-color: orange;
// }

.pi-btn.loading {
    //border-width: 1px;
    border-color: transparent;
    &::before,
    &::after,
    span::before,
    span::after {
        animation-fill-mode: forwards;
        animation-iteration-count: infinite;
        animation-timing-function: ease-in-out;
        background: #ccc;
        content: "";
        opacity: 0;
        position: absolute;
        transition: opacity 1s ease;
    }
    &::before,
    &::after {
        height: 2px;
        width: 0%;
    }
    &::before {
        right: 0;
        top: 0;
    }
    &::after {
        bottom: 0;
        left: 0;
    }
    span::before,
    span::after {
        height: 0%;
        width: 2px;
    }
    span::before {
        left: 0;
        top: 0;
    }
    span::after {
        bottom: 0;
        right: 0;
    }
    &::before,
    &::after,
    span::before,
    span::after {
        opacity: 1;
    }
    &::before {
        animation-name: btn-border-top;
        animation-duration: $btn-duration-total;
    }
    &::after {
        animation-name: btn-border-bottom;
        animation-delay: $btn-duration * 2;
        animation-duration: $btn-duration-total;
    }
    span::before {
        animation-name: btn-border-span-left;
        animation-delay: $btn-duration;
        animation-duration: $btn-duration-total;
    }
    span::after {
        animation-name: btn-border-span-right;
        animation-delay: $btn-duration * 3;
        animation-duration: $btn-duration-total;
    }
}

.overflow {
    border-right: none;
    border-top-right-radius: 0px;
    border-bottom-right-radius: 0px;
}

@mixin btnAnimations($name, $anchor, $edge) {
    $anchor-op: "left";
    @if $anchor== "left" {
        $anchor-op: "right";
    } @else if $anchor== "top" {
        $anchor-op: "bottom";
    } @else if $anchor== "bottom" {
        $anchor-op: "top";
    }
    @keyframes #{$name} {
        0% {
            #{$anchor-op}: auto;
            #{$anchor}: 0;
            #{$edge}: 0%;
        }
        12.5% {
            #{$anchor-op}: auto;
            #{$anchor}: 0;
            #{$edge}: 100%;
        }
        12.6% {
            #{$anchor-op}: 0;
            #{$anchor}: auto;
        }
        50% {
            #{$edge}: 100%;
        }
        62.5% {
            #{$edge}: 0%;
        }
        100% {
            #{$anchor-op}: 0;
            #{$anchor}: auto;
            #{$edge}: 0%;
        }
    }
}

@include btnAnimations(btn-border-top, "right", "width");
@include btnAnimations(btn-border-bottom, "left", "width");
@include btnAnimations(btn-border-span-left, "top", "height");
@include btnAnimations(btn-border-span-right, "bottom", "height");
</style>

<template> </template>

<script>
/* Base component to be extended by goals or predicates
 * It handles the drag and positioning problematics
 */

import _ from "lodash";

export default {
    props: ["selectMode", "displayMode"],
    data: function() {
        return {
            html: "",
            decorated: false,
        };
    },
    created: function() {
        // we start in a "no drag" state
        this.drag = false;
        this.startX = null;
        this.startY = null;
        this.clickTimeout = null; // click timeout, to differentiate long clicks and short clicks
        this.touchTimeout = null;

        // html interpretation
        if (this.displayMode === "html") {
            this.html = this.toHTML();
        } else {
            this.html = this.toMathML();
        }

        // action scouting
        this.dndActions = {};

        // caching prover responses. this.dndCache[src][dst] give the prover response. Use "null" if src/dst is unkown
        this.clickCache = null;
        this.dndCache = {};
        this.dndScoutState = "not started";
        this.rootId = null;

        this.cloneMetadata();
    },
    mounted: function() {
        if (this.displayMode === "html") {
            this.updateHTML();
            this.hide();
            this.onDisplayed(() => {
                // console.log("Displayed element " + this.getHandle());
                this.assignPosition();
                this.$nextTick(() => {
                    this.show();
                });
                // console.log("width: " + width);
                // console.log("contentWidth: " + contentWidth);
            });
        }
    },
    beforeUpdate: function() {
        this.decorated = false; // our HTML decoration is now wrong
        this.binded = false;
        this.resetDndActions(); // reset action scouting
    },
    updated: function() {
        //this.hide();
        if (this.displayMode === "mathml") {
            this.showMathMl();
        } else if (this.displayMode === "html") {
            this.updateHTML();
            if (this.decorated) {
                this.bindDecoratedHTMLActions();
                if (this.selectMode) {
                    $(this.$el)
                        .find("span:hover")
                        .trigger("mouseenter");
                }
            }

            this.onDisplayed(() => {
                this.assignPosition();
                //this.show();
            });
        }
        this.$proofCanvas.fitHypsZone(this);
    },
    computed: {
        $proofCanvas: function() {
            var parent = this.$parent;
            while (!parent.proofState) {
                parent = parent.$parent;
            }
            return parent;
        }
    },
    methods: {
        hide() {
            $(this.$el).css("visibility", "hidden");
        },

        show() {
            $(this.$el).css("visibility", "visible");
        },

        isLoading() {
            return this.decorated !== true;
        },

        isHidden() {
            return this.$el.offsetParent === null;
        },

        uniqId() {
            return Math.random()
                .toString(36)
                .substr(2, 9);
        },

        onDisplayed(cb) {
            $(this.$el).ready(() => {
                if (!this.isHidden()) {
                    cb();
                } else {
                    var observer = new IntersectionObserver(
                        (entries, observer) => {
                            entries.forEach(entry => {
                                if (entry.intersectionRatio > 0) {
                                    observer.unobserve(this.$el);
                                    cb();
                                }
                            });
                        },
                        { root: document.documentElement }
                    );

                    observer.observe(this.$el);
                }
            });
        },

        toHTML() {
            throw "Should be overspecified in the specific logic component";
        },

        updateHTML: async function() {
            if (!this.decorated) {
                // first get the direct html from prover, then when ready, get the decorated HTML

                this.decorated = true;
                this.html = await this.getDecoratedHTML();
                $(this.$el).removeClass("loading");
                this.hideGeneralize();

                // Get the HTML associated to this item
                let item = $.parseHTML(this.html);
                let subitems = $(this.$el).find("span[id]");
                // Ignore generalize button in goal
                if ($(this.$el).hasClass("pi-goal")) {
                    item = subitems.first();
                }

                // Register all paths to subitems into proof canvas
                let self = this;
                $(item).each(function() {
                    let id = $(this).attr("id");
                    if (id) {
                        self.$proofCanvas.registerPath(id, self);
                    }
                });

                subitems.each(function() {
                    let elementId = $(this).attr("id");
                    if (elementId) {
                        self.$proofCanvas.registerPath(elementId, self);
                    }
                });
            }
        },

        getSelectedPaths() {
            let metadata = this.getMetadata();
            return _.get(metadata, ["selectedPaths"]) || [];
        },

        addSelectedPath(path) {
            let selectedPaths = this.getSelectedPaths();

            selectedPaths.push(path);
            this.$proofCanvas.addSelectedPath(this.getSubGoal().handle, path);

            this.assignMetadata({ selectedPaths: selectedPaths });
            this.$proofCanvas.forceUpdate();
        },

        removeSelectedPath(path) {
            let selectedPaths = this.getSelectedPaths();

            if (selectedPaths.indexOf(path) !== -1) {
                selectedPaths.splice(selectedPaths.indexOf(path), 1);
                this.$proofCanvas.removeSelectedPaths(this.getSubGoal().handle, path);

                this.assignMetadata({ selectedPaths: selectedPaths });
                this.$proofCanvas.forceUpdate();
            }
        },

        removeAllSelectedPaths() {
            this.$proofCanvas.removeSelectedPaths(this.getSubGoal().handle, ...this.getSelectedPaths());
            this.assignMetadata({ selectedPaths: [] });
        },

        // Attach actions to the newly defined subsets
        bindDecoratedHTMLActions() {
            var self = this;

            var applyAction = function() {
                //console.log(this.getRootId() + " is doing something !");
                // check what actions are available
                var id = $(this).attr("id");
                var actionsClasses = $(this)
                    .attr("class")
                    .split(/\s+/)
                    .filter(s => s.startsWith("action-"));
                var actions = actionsClasses.map(s => s.replace("action-", ""));

                if (actions.length == 0) {
                    //throw "Incorrect number of actions bound to " + $(this).attr('id');
                    self.$proofCanvas.showWarningMessage("Nothing to do.");
                } else if (actions.length == 1) {
                    // just retrieve apply the action
                    var actionCode = self.$proofCanvas.getActionCode(
                        id,
                        actions[0]
                    );
                    self.apply(actionCode);
                } else {
                    // several actions available. Let the user choose one
                    // generate dropdown on the fly
                }
            };

            if (!this.binded) {
                $(this.$el)
                    .find(".action")
                    .off("dblclick")
                    .on("dblclick", applyAction);

                if (this.selectMode) {
                    $(this.$el)
                        .find("span")
                        .on("mouseenter", function() {
                            // filter out divs that are not at the bottom
                            if ($(this).find("span").length == 0) {
                                $(this)
                                    .closest("[id]")
                                    .addClass("selectable")
                                    .off("click")
                                    .on("click", function(e) {
                                        e.preventDefault();
                                        e.stopPropagation();

                                        let id = $(this).attr("id");

                                        if (
                                            !self
                                                .getSelectedPaths()
                                                .includes(id)
                                        ) {
                                            // first click: select this path
                                            console.log("selecting path: ", id);

                                            // unselect all parents that were selected before
                                            $(this)
                                                .parents("[id]")
                                                .each(function() {
                                                    let id = $(this).attr("id");
                                                    self.removeSelectedPath(id);
                                                });

                                            self.addSelectedPath(id);
                                        } else {
                                            // second click: unselect this path
                                            console.log(
                                                "unselecting path: ",
                                                id
                                            );
                                            self.removeSelectedPath(id);
                                        }
                                    });
                            }
                        })
                        .on("mouseleave", function() {
                            if ($(this).find("span").length == 0) {
                                $(this)
                                    .closest("[id]")
                                    .removeClass("selectable")
                                    .off("click");
                            }
                        });
                } else {
                    // if not select mode, delete all handlers
                    $(this.$el)
                        .find("span")
                        .removeClass("selectable")
                        .off("click")
                        .off("mouseenter")
                        .off("mouseleave");
                }

                // if we have a selected path, highlight it
                for (let selectedPath of this.getSelectedPaths()) {
                    let div = document.getElementById(selectedPath);
                    $(div).addClass("selected");
                }

                this.binded = true;
            }
        },

        setDraggingFromCanvas: function(b, event) {
            $(this.$proofCanvas.$el).off("mousemove");
            $(this.$proofCanvas.$el).off("mouseup");
            $(event.target).off("touchmove");
            $(event.target).off("touchend");

            if (b) {
                $(this.$proofCanvas.$el).on(
                    "mousemove",
                    this.mousemove.bind(this)
                );
                $(this.$proofCanvas.$el).on(
                    "mouseup",
                    this.mouseup.bind(this)
                );
                $(event.target).on(
                    "touchmove",
                    this.touchmove.bind(this)
                );
                $(event.target).on(
                    "touchend",
                    this.touchend.bind(this)
                );
            }
        },

        copyToWorkZone() {
            return new Promise(async (resolve, reject) => {
                var c = this.getCoord();
                this.setPosition(c.x, c.y);
                this.assignMetadata({ inWorkZone: true });
                this.$proofCanvas.$forceUpdate();
                this.$proofCanvas.forceUpdate();

                this.$proofCanvas.$nextTick(async () => {
                    await this.$proofCanvas.ready();

                    window.requestAnimationFrame(() => {
                        window.requestAnimationFrame(() => {
                            var copy = this.$proofCanvas.get(this.getHandle());
                            resolve(copy);
                        });
                    });
                });
            });
        },

        mousedown: function(e) {
            e = e || window.event;
            e.preventDefault();

            this.clickTimeout = setTimeout(async () => {
                // If the predicate is not in work zone, we need to move it first
                if (!this.isInWorkZone()) {
                    // add dragged class to our corresponding predicate-dropspace
                    let handle = $(this.$el).attr("data-handle");

                    // TODO: refactor this procedure so we don't have to interrupt current DND

                    // Copy the element into the workzone before the action
                    // 1. release mousedown
                    this.mouseup(e);

                    let { clientX, clientY } = this.getEventCoordinates(e);

                    // 2. Adjust the starting position
                    var pos = this.convertPositionToWorkzone({
                        x: clientX,
                        y: clientY
                    });
                    this.startX = pos.x;
                    this.startY = pos.y;

                    // 3. copy the element to workzone, with the actual coordinate relatives to the canvas
                    var copy = await this.copyToWorkZone();
                    $(copy.$el).addClass("dragged");
                    copy.startDragAndDrop(e);
                } else {
                    this.startDragAndDrop(e);
                }
            }, 300);
        },

        mousemove: async function(e) {
            e = e || window.event;
            e.preventDefault();

            this.doDragAndDrop(e);
        },

        mouseup: function(e) {
            e = e || window.event;
            e.preventDefault();

            clearTimeout(this.clickTimeout);
            this.stopDragAndDrop(e);
        },

        tap: function(e) {
            // check that it's a touch event, because it captures click too
            if( e.changedTouches ) {
                $(this.$el)
                    .find(".action")
                    .eq(0)
                    .dblclick();
            }
        },

        long: function(e) {
            console.log("longtap !");
        },

        touchstart: function(e) {
            e = e || window.event;
            e.preventDefault();

            this.touchTimeout = setTimeout(async () => {
                // If the predicate is not in work zone, we need to move it first
                if (!this.isInWorkZone()) {
                    // add dragged class to our corresponding predicate-dropspace
                    let handle = $(this.$el).attr("data-handle");

                    // TODO: refactor this procedure so we don't have to interrupt current DND

                    // Copy the element into the workzone before the action
                    // 1. release touchend
                    this.touchend(e);

                    let {
                        clientX,
                        clientY,
                        pageX,
                        pageY
                    } = this.getEventCoordinates(e);

                    // 2. Adjust the starting position
                    var pos = this.convertPositionToWorkzone({
                        x: clientX,
                        y: clientY
                    });
                    this.startX = pos.x;
                    this.startY = pos.y;

                    // 3. copy the element to workzone, with the actual coordinate relatives to the canvas
                    console.log(this.$el);
                    var copy = await this.copyToWorkZone();
                    $(copy.$el).addClass("dragged");
                    this.$nextTick(() => {
                        // This doesn't seem to work with Touch events. For some reason, the touchmove event doesn't trigger
                        // when it didn't get a proper, non-simulated touchstart
                        copy.startDragAndDrop(e);
                    });
                } else {
                    this.startDragAndDrop(e);
                }
            }, 300);
        },

        touchcancel: function(e) {
        },

        touchmove: function(e) {
            e = e || window.event;
            if (e.preventDefault) {
                e.preventDefault();
            }

            this.doDragAndDrop(e);
        },

        touchend: function(e) {
            e = e || window.event;
            if (e) {
                e.preventDefault();
            }

            this.stopDragAndDrop(e);
            clearTimeout(this.touchTimeout);
        },

        getEventCoordinates(e) {
            var rect = e.target.getBoundingClientRect();
            return {
                pageX: e.pageX
                    ? e.pageX
                    : _.get(e, ["changedTouches", 0, "pageX"]),
                pageY: e.pageY
                    ? e.pageY
                    : _.get(e, ["changedTouches", 0, "pageY"]),
                clientX: e.clientX
                    ? e.clientX
                    : _.get(e, ["changedTouches", 0, "clientX"]),
                clientY: e.clientY
                    ? e.clientY
                    : _.get(e, ["changedTouches", 0, "clientY"])
            };
        },

        // executed when user starts a drag and drop
        startDragAndDrop: async function(e) {
            // start dragging get the mouse cursor position at startup
            this.drag = true;
            if (!this.isInWorkZone()) {
                throw new Error("Element is not in work zone");
            } else {
                console.log("Element is in work zone !");

                if (this.subgoal) {
                    this.originalPosition = this.getSavedPosition();
                }

                let { clientX, clientY } = this.getEventCoordinates(e);
                this.startX = clientX;
                this.startY = clientY;
                this.startZone = this.getCurrentZone();
                $(this.$el).addClass("dragged");

                this.setDraggingFromCanvas(true, e);
            }

            if (!this.subgoal) {
                this.showGeneralize();
            }
        },

        // executed continuously while user perform drag and drop
        doDragAndDrop: async function(e) {
            if (this.drag) {
                // set new position
                let { clientX, clientY } = this.getEventCoordinates(e);
                var diffX = clientX - this.startX;
                var diffY = clientY - this.startY;
                this.startX = clientX;
                this.startY = clientY;

                if (this.alignment == "left") {
                    this.changePosition(diffX, diffY);
                } else if (this.alignment == "right") {
                    this.changePosition(-diffX, diffY);
                } else {
                    console.error(JSON.stringify(this));
                    throw new Error("Object has no alignment");
                }

                // if we're dragging over the hypothesis zone, we should allow the drop
                // show visual return
                var pos = this.getCoord();
                this.$proofCanvas.get("plist").setDragOver(pos.x < 0);

                // if we overlap a highlight element, we need to interrogate the prover again with more details
                let overlapedElement = this.overlapHighlight();

                // check if we overlap a dropspace element. If so, add "droppable" class to it
                $(".predicate-dropspace").removeClass("droppable");
                let dropspaceElement = this.overlapDropspace();
                if (!this.is("subgoal") && dropspaceElement !== null) {
                    $(dropspaceElement).addClass("droppable");
                }

                // if already possible, highlight drag and drop destinations
                let dndSource = this.getRootId();
                let dndDest = this.intersectId();
                await this.setCurrentDndContext(dndSource, dndDest);
            }
        },

        // executed when users finally drops the drag item
        stopDragAndDrop: async function(e) {
            if (this.drag) {
                this.setDraggingFromCanvas(false, e);
                this.drag = false;
                this.startX = null;
                this.startY = null;

                // Check with all divs in dndActions if we are hover them
                var action = this.getDropAction();
                if (action !== null) {
                    // It's a valid action
                    if (!this.subgoal) {
                        this.setToHypothesisZone();
                    } else {
                        this.setPosition(
                            this.originalPosition.x,
                            this.originalPosition.y
                        );
                    }

                    if (action.generalize) {
                        // it's a generalize, apply the generalize action
                        this.generalize(action.predicate);
                    } else {
                        // if so, it's a "action drop"
                        this.drop(action.action);
                    }
                } else {
                    // we have no action to execute
                    // check if we overlaped a dropspace element (meaning user is trying to reorder hyph)
                    $(".predicate-dropspace").removeClass("droppable");
                    let dropspaceElement = this.overlapDropspace();
                    let dropspaceElementDataHandle =
                        dropspaceElement !== null &&
                        $(dropspaceElement).attr("data-handle");
                    if (
                        (this.is("expression") || this.is("predicate")) &&
                        dropspaceElement !== null &&
                        dropspaceElementDataHandle !== undefined
                    ) {
                        $(dropspaceElement).removeClass("droppable");

                        let fromHandle = $(this.$el).attr("data-handle");
                        let dropBeforeHandle = $(dropspaceElement).attr(
                            "data-handle"
                        );

                        if (fromHandle !== dropBeforeHandle) {
                            this.setToHypothesisZone();
                            let fromHandleId = parseInt(fromHandle);
                            let dropBeforeHandleId =
                                dropBeforeHandle === "last"
                                    ? null
                                    : parseInt(dropBeforeHandle);
                            this.moveHyp(fromHandleId, dropBeforeHandleId);
                        }
                    } else {
                        this.dropToCorrectZone();

                        // If we were changing the zone for this proposition, apply the change
                        if (this.getCurrentZone() !== this.startZone) {
                            // apply the change, force canvas update
                            this.$proofCanvas.forceUpdate();
                        } else {
                            // If we droppped elsewhere, cancel the current dnd if there was one
                            this.cancelDrop();
                        }
                    }
                }

                // in case some element was changed zones
                this.$proofCanvas.$forceUpdate(); // will break dnd
            }

            $(this.$el).removeClass("dragged");
            $(".predicate-dropspace").removeClass("dragged");

            this.hideGeneralize();
        },

        // set the correct zone into the proposition's metadata
        dropToCorrectZone() {
            var c = this.getCoord();
            var inWorkZone = c.x >= 0;
            if (this.is("subgoal") && !inWorkZone) {
                this.setPosition(
                    this.originalPosition.x,
                    this.originalPosition.y
                );
            } else {
                this.assignMetadata({ inWorkZone: inWorkZone });
                if (inWorkZone) {
                    // this is a drop into hypothesis zone
                    this.$proofCanvas.get("plist").setDragOver(false);
                    this.$proofCanvas.$forceUpdate();
                }
            }
        },

        setToHypothesisZone() {
            this.assignMetadata({ inWorkZone: false });
            this.$proofCanvas.get("plist").setDragOver(false);
            this.$proofCanvas.$forceUpdate();
        },

        // if the current dragged element overlap a .predicate-dropspace div (to invert hypothesis orders, for exemple)
        // return the current overlaped element
        overlapDropspace() {
            let self = this;
            let thisRect = this.$el.getBoundingClientRect();
            let overlapedElement = null;

            $(".predicate-dropspace").each(function() {
                var rect = $(this)[0].getBoundingClientRect();

                if (self.overlap(thisRect, rect)) {
                    overlapedElement = this;
                    return false;
                }
            });

            return overlapedElement;
        },

        // if the current dragged element overlap a highlighted element
        // return id of the current overlaped element, or null if no overlap
        // If multiple elements are overlaped, return the id of the most top-left element (first from top, then from left)
        overlapHighlight() {
            let self = this;
            let thisRect = this.$el.getBoundingClientRect();
            let overlapedElements = [];

            // find the highlighted span overlaped with this element
            $(".pi-btn:not(.dragged) span.highlight").each(function() {
                var rect = $(this)[0].getBoundingClientRect();

                if (self.overlap(thisRect, rect)) {
                    overlapedElements.push(this);
                }
            });

            if (overlapedElements.length == 0) {
                return null;
            } else if (overlapedElements.length == 1) {
                return $(overlapedElements[0]).attr("id");
            } else {
                // if multiple elements overlaped, find the most top-left element
                let mostTopLeft = null;
                _.each(overlapedElements, el => {
                    let rect = el.getBoundingClientRect();

                    if (mostTopLeft == null) {
                        mostTopLeft = el;
                    } else {
                        let currTopLeftRect = mostTopLeft.getBoundingClientRect();
                        if (rect.top < currTopLeftRect.top) {
                            mostTopLeft = el;
                        } else if (rect.top == currTopLeftRect.top) {
                            if (rect.left < currTopLeftRect.left) {
                                mostTopLeft = el;
                            }
                        }
                    }
                });
                return $(overlapedElements[0]).attr("id");
            }
        },

        // if the current dragged element overlap a identified path
        // return id of the current overlaped element, or null if no overlap
        // If multiple elements are overlaped, return the id of the most top-left element (first from top, then from left)
        overlapId() {
            let self = this;
            let thisRect = this.$el.getBoundingClientRect();
            let overlapedElements = [];

            // find the highlighted span overlaped with this element
            $(".pi-btn:not(.dragged) span[id]").each(function() {
                var rect = $(this)[0].getBoundingClientRect();

                if (self.overlap(thisRect, rect)) {
                    overlapedElements.push(this);
                }
            });

            if (overlapedElements.length == 0) {
                return null;
            } else if (overlapedElements.length == 1) {
                return $(overlapedElements[0]).attr("id");
            } else {
                // if multiple elements are overlaped, first remove divs that contains
                // other elements, as we only want the overlaped leafs here
                let leafElements = [];
                for (let div of overlapedElements) {
                    let containOther = false;
                    for (let other of overlapedElements) {
                        if ($(div).has(other).length > 0) {
                            containOther = true;
                        }
                    }

                    if (!containOther) {
                        leafElements.push(div);
                    }
                }

                if (leafElements.length == 1) {
                    return $(leafElements[0]).attr("id");
                } else {
                    // if multiple elements are still overlaped, return the most top-left element
                    let mostTopLeft = null;
                    _.each(leafElements, el => {
                        let rect = el.getBoundingClientRect();

                        if (mostTopLeft == null) {
                            mostTopLeft = el;
                        } else {
                            let currTopLeftRect = mostTopLeft.getBoundingClientRect();
                            if (rect.top < currTopLeftRect.top) {
                                mostTopLeft = el;
                            } else if (rect.top == currTopLeftRect.top) {
                                if (rect.left < currTopLeftRect.left) {
                                    mostTopLeft = el;
                                }
                            }
                        }
                    });
                    return $(leafElements[0]).attr("id");
                }
            }
        },

        showMathMl() {
            let mathml = this.toMathML();
            this.html = mathml;
            // MathJax.Hub.Queue(["Typeset", MathJax.Hub, this.$el]);
        },

        intersectId() {
            let self = this;
            let thisRect = this.$el.getBoundingClientRect();
            let intersectedElements = [];

            // find the highlighted span overlaped with this element
            $(".pi-btn:not(.dragged) span[id]").each(function() {
                if (self.intersectWithId($(this).attr("id"))) {
                    intersectedElements.push(this);
                }
            });

            if (intersectedElements.length == 0) {
                return null;
            } else if (intersectedElements.length == 1) {
                return $(intersectedElements[0]).attr("id");
            } else {
                // if multiple elements are overlaped, first remove divs that contains
                // other elements, as we only want the overlaped leafs here
                let leafElements = [];
                for (let div of intersectedElements) {
                    let containOther = false;
                    for (let other of intersectedElements) {
                        if ($(div).has(other).length > 0) {
                            containOther = true;
                        }
                    }

                    if (!containOther) {
                        leafElements.push(div);
                    }
                }

                if (leafElements.length == 1) {
                    return $(leafElements[0]).attr("id");
                } else {
                    // It's alright, doesn't seem to break anything

                    // throw new Error(
                    //     "We should only intersect 1 leaf element here"
                    // );
                }
            }
        },

        // intelligent function to find actual drop target
        // If multiples target available, select the most left one
        findDropTarget(actions) {
            let mostLeftAction = null;
            let bestLeftOffset = +Infinity;

            _.each(actions, action => {
                let divOffsetLeft = document.getElementById(action.divId)
                    .offsetLeft;
                if (divOffsetLeft < bestLeftOffset) {
                    bestLeftOffset = divOffsetLeft;
                    mostLeftAction = action;
                }
            });

            return mostLeftAction;
        },

        // Return the action that will be executed if we drop now
        // If we're not hover a valid div, return null
        getDropAction() {
            var r = null;
            var actions = [];
            var thisRect = this.$el.getBoundingClientRect();
            _.each(this.dndActions, (action, divId) => {
                var div = document.getElementById(divId);
                if (div) {
                    if (this.intersectWithId(divId)) {
                        actions.push({ divId: divId, action: action });
                        //return false; // end the loop
                    }
                } else {
                    console.error(
                        "Error caught: prover wanted to highlights an unexisting div: " +
                            divId
                    );
                    console.error(
                        'Run for more info: window.goal.actions({"kind": "dnd", "source": "' +
                            divId +
                            '"})'
                    );
                }
            });

            if (actions.length > 0) {
                return this.findDropTarget(actions);
            } else {
                // check if we overlap the generalize action of the goal
                let generalizeDiv = $(".pi-goal .generalize");
                let generalizeRect = generalizeDiv[0].getBoundingClientRect();
                if (this.overlap(thisRect, generalizeRect)) {
                    if (!this.predicate) {
                        throw "generalize can't only be done on predicates !";
                    }
                    return { generalize: true, predicate: this.predicate };
                } else {
                    return null;
                }
            }
        },

        generalize(predicate) {
            this.$proofCanvas.generalize(predicate);
        },

        showGeneralize() {
            this.$proofCanvas.showGeneralize();
        },

        hideGeneralize() {
            this.$proofCanvas.hideGeneralize();
        },

        highlightGeneralize() {
            this.$proofCanvas.highlightGeneralize();
        },

        unhighlightGeneralize() {
            this.$proofCanvas.unhighlightGeneralize();
        },

        highlightDrop(divId) {
            this.$proofCanvas.highlightDrop(divId);
        },

        unhighlightDrop() {
            this.$proofCanvas.unhighlightDrop();
        },

        highlightDropTarget(divId) {
            this.$proofCanvas.highlightDropTarget(divId);
        },

        unhighlightDropTarget() {
            this.$proofCanvas.unhighlightDropTarget();
        },

        highlightDropDestination(divId) {
            this.$proofCanvas.highlightDropDestination(divId);
        },

        unhighlightDropDestination() {
            this.$proofCanvas.unhighlightDropDestination();
        },

        drop(action) {
            this.apply(action.action);
        },

        moveHyp(fromHandle, beforeHandle) {
            if (this.getSubGoal) {
                this.$proofCanvas.moveHyp(
                    this.getSubGoal(),
                    fromHandle,
                    beforeHandle
                );
            } else {
                throw "Hypothesis and expression only should be moved";
            }
        },

        // apply an action, with error handling
        apply(actionCode) {
            this.$proofCanvas.sendActionCode(actionCode);
        },

        setMetadata(metadata) {
            throw "Should be overspecified in the specific logic component";
        },

        getMetadata() {
            throw "Should be overspecified in the specific logic component";
        },

        cloneMetadata() {
            this.setMetadata(_.clone(this.getMetadata()));
        },

        getHandle() {
            throw "Should be overspecified in the specific logic component";
        },

        // Object.assign on metadata, doesn't overwrite other properties
        assignMetadata(o) {
            var meta = this.getMetadata() || {};
            Object.assign(meta, o);
            return this.setMetadata(meta);
        },

        isInWorkZone() {
            var md = this.getMetadata() || {};
            return md.inWorkZone;
        },

        quickSwitchToWorkZone() {
            throw "should be redefined !";
        },

        setPosition(x, y) {
            this.setAbsolutePosition(x, y);
            this.savePosition(x, y);
        },

        setAlignment(alignment) {
            this.assignMetadata({
                alignment: alignment
            });
        },

        removeAlignment() {
            this.assignMetadata({
                alignment: undefined
            });
        },

        setAbsolutePosition(x, y) {
            if (this.alignment == "left") {
                this.$el.style.left = x ? x + "px" : "";
            } else if (this.alignment == "right") {
                this.$el.style.right = x ? x + "px" : "";
            }
            this.$el.style.top = y ? y + "px" : "";
        },

        getSavedPosition() {
            var metadata = this.getMetadata();
            var x = _.get(metadata, "coord.x");
            var y = _.get(metadata, "coord.y");
            return { x: x, y: y };
        },

        changePosition(deltaX, deltaY) {
            let pos = this.getSavedPosition();
            let x = pos.x;
            let y = pos.y;
            if (!x || !y) {
                // get the current position
                var c = this.getCoord();
                x = c.x;
                y = c.y;
            }

            this.setPosition(x + deltaX, y + deltaY);
        },

        savePosition(x, y) {
            var c = this.getCoord();
            if (x) c.x = x;
            if (y) c.y = y;

            // we also wanna save the width and height
            this.assignMetadata({
                coord: c
            });
        },

        convertPositionToWorkzone(pos) {
            return {
                x: pos.x - this.$proofCanvas.getHypothesisZone().width(), // size of the hypothesis zone
                y: pos.y
            };
        },

        // general algorithm for deciding the position of the box
        // after an update in the proof
        assignPosition() {
            if (this.hasSavedPosition()) {
                this.restoreSavedPosition();
            } else {
                this.assignStaticPosition();
            }
        },

        hasSavedPosition() {
            var metadata = this.getMetadata();
            var x = _.get(metadata, "coord.x");
            var y = _.get(metadata, "coord.y");
            return x !== undefined || y !== undefined;
        },

        restoreSavedPosition() {
            var metadata = this.getMetadata();

            let savedAlignement = _.get(metadata, "alignment");

            var x = _.get(metadata, "coord.x");
            var y = _.get(metadata, "coord.y");
            this.setPosition(x, y);
        },

        // Box-Muller transform to get a gaussian distribution random number
        // https://stackoverflow.com/questions/25582882/javascript-math-random-normal-distribution-gaussian-bell-curve
        gaussianRandom() {
            var u = 0,
                v = 0;
            while (u === 0) u = Math.random(); //Converting [0,1) to (0,1)
            while (v === 0) v = Math.random();
            let num =
                Math.sqrt(-2.0 * Math.log(u)) * Math.cos(2.0 * Math.PI * v);
            num = num / 10.0 + 0.5; // Translate to 0 -> 1
            if (num > 1 || num < 0) return randn_bm(); // resample between 0 and 1
            return num;
        },

        /*
        // return a mutable coord by copying properties from getBoundingClientRect()
        getCoord() {
            // Simulate div.getBoundingClientRect() but in synchronous
            var w = $(this.$el).width();
            var h = $(this.$el).height();
            var container = this.$proofCanvas.getWorkZone();
            var containerCoord = {
                x: container[0].offsetLeft,
                y: container[0].offsetTop,
                width: container.width(),
                height: container.height(),
            }
            var x = this.$el.offsetLeft - containerCoord.x;
            var y = this.$el.offsetTop - containerCoord.y;

            return {
                x: x,
                y: y,
                width: w,
                height: h,
                left: x,
                right: x + w,
                top: y,
                bottom: y + h,
                // also save container coord so we know the context of this position
                container: containerCoord
            }
        },
        */

        // get element coordinates relative to the work zone
        getCoord() {
            let container = this.$proofCanvas.getWorkZone();
            let elBCR = this.$el.getBoundingClientRect();
            if (
                elBCR.x === 0 &&
                elBCR.y === 0 &&
                elBCR.width == 0 &&
                elBCR.height == 0
            ) {
                throw "element bounding rect returned zeros!";
            }

            let containerBCR = container[0].getBoundingClientRect();
            let w = $(this.$el).width();
            let h = $(this.$el).height();
            let x = elBCR.x - containerBCR.x;
            let y = elBCR.y - containerBCR.y;

            return {
                x: x,
                y: y,
                w: w,
                h: h,
                top: y,
                left: x,
                right: x + w,
                bottom: y + h,
                container: {
                    w: container.width(),
                    h: container.height()
                }
            };
        },

        /*
        getPositionCoord(x, y) {
            var c = this.getCoord();
            c.left = c.x = x;
            c.top = c.y = y;
            c.right = c.left + c.w;
            c.bottom = c.top + c.h;
            return c;
        },
        */

        hasPosition() {
            return this.$el.style.top || this.$el.style.left;
        },

        // Assign a random position to the button, from a gaussian distribution
        // (assign more frequently to the center)
        // If overlapping another button, distribute again
        assignRandomPosition() {
            var security = 0;
            do {
                // since some tabs are not displayed right away, take the parent's parent to have right width/height
                var parentWidth = $(this.$el)
                    .parent()
                    .parent()
                    .width();
                var parentHeight = $(this.$el)
                    .parent()
                    .parent()
                    .height();
                var c = this.getCoord();

                // choose random coord between (0, 0) and (parentWidth - width, parentHeight  - height)
                var x = parseInt(this.gaussianRandom() * (parentWidth - c.w));
                var y = parseInt(this.gaussianRandom() * (parentHeight - c.h));
                this.setPosition(x, y);

                // build our new rect (since the div hasn't been updated yet)
                var c = this.getPositionCoord(x, y);
                security++;
            } while (this.isoverlappingAnotherButton(c) && security < 100);

            if (security >= 100) {
                throw "failed to assign a random clean position to " +
                    this.toString();
            }
        },

        assignStaticPosition() {
            var c = this.getCoord();
            var XMargin = 150;
            var startingY = 50;
            var YMargin = 40;

            var x = (c.container.w * 10) / 100; // take 10% margin from the border of the container
            var y = startingY + this.getPosition() * (36 + YMargin); // buttons are 36px height
            this.setPosition(x, y);
            this.setAlignment(this.alignment);
        },

        getSubGoal() {
            throw "Should be overspecified in the specific logic component";
        },

        // returns true if we overlap the div
        // rect is the return of the other's div.getBoundingClientRect()
        // c is our current coord system
        overlap(rect, c = this.getCoord()) {
            var overlap = !(
                c.right < rect.left ||
                c.left > rect.right ||
                c.bottom < rect.top ||
                c.top > rect.bottom
            );

            return overlap;
        },

        // intersect(rect, x, y) returns true if the point (x, y) is inside rect
        intersect(rect, x, y) {
            return x <= rect.left ||
                   x >= rect.right ||
                   y <= rect.top ||
                   y >= rect.bottom;
        },

        // [intersectWithId(id)] returns true if the div at path [id] intersects
        // with this button.
        //
        // More precisely, we check for an intersection with the left border of
        // this button if it is a goal, or if both this button and the div's
        // button are predicates/expressions. Otherwise this button is a
        // predicate/expression and the div is in a goal, and we check for an
        // intersection with the right border. 
        intersectWithId(id) {
            const intersectIntervals = function(i1, i2) {
                return i1.min <= i2.max && i1.max >= i2.min;
            };

            const thisRect = this.$el.getBoundingClientRect();
            const divRect = document
                .getElementById(id)
                .getBoundingClientRect();

            const btn = this.$proofCanvas.getButton(id);
            const pointerLeft = this.is("subgoal") ||
                                (this.is("predicate") || this.is("expression")) &&
                                (btn.is("predicate") || btn.is("expression"));

            const x = pointerLeft ? thisRect.left : thisRect.right;
            const hThis = { min: x, max: x };
            const vThis = { min: thisRect.top, max: thisRect.bottom };
            const hDiv = { min: divRect.left, max: divRect.right };
            const vDiv = { min: divRect.top, max: divRect.bottom };

            return intersectIntervals(hThis, hDiv) && intersectIntervals(vThis, vDiv);
        },

        // Return true if this div is overlapping another button
        // Optional parameter c is result of div.getBoundingClientRect() or this.getCoord()
        // If we want to test a new position before it's been applied to DOM
        isoverlappingAnotherButton(c = this.getCoord()) {
            var subgoal = this.getSubGoal();
            var overlapping = false;

            // check if we overlap the subgoal first
            if (this.getHandle() !== subgoal.handle) {
                var metadata = subgoal.getmeta();
                if (this.overlap(metadata.coord, c)) {
                    return true;
                }
            }

            // check if we overlap one of the predicates
            _.each(subgoal.context(), predicate => {
                if (this.getHandle() !== predicate.handle) {
                    var metadata = predicate.getmeta();
                    if (metadata) {
                        if (this.overlap(metadata.coord, c)) {
                            overlapping = true;
                            return false; // stop the loop
                        }
                    } else {
                        // this predicate was not assigned a position yet, ignore it for now
                    }
                }
            });

            return overlapping;
        },

        // debug function
        sleep(n) {
            return new Promise(resolve => {
                setTimeout(resolve, n * 1000);
            });
        },

        getRootIdForType(itemtype) {
            if (this.rootId) {
                return this.rootId;
            } else {
                var id;
                var html = this.toHTML();
                var parsed = jQuery.parseHTML(html);

                var firstNode = $(parsed).find("span[id*=\"" + itemtype + "#\"]").first();
                id = $(firstNode).attr("id");
                this.rootId = id;
                return id;
            }
        },

        getRootId() {
            throw "Should be overspecified in the specific logic component";
        },

        getActions(kind, source, dest) {
            var selection = [];

            if (this.getSubGoal) {
                selection = this.$proofCanvas.getSelection(this.getSubGoal());
            }

            let sourceSelection, destinationSelection;
            if (!source) {
                source = this.getRootId();
                sourceSelection = this.getSelectedPaths();
            } else {
                let sourceButton = this.$proofCanvas.getButton(source);
                if (sourceButton === undefined) {
                    console.error("Source button not found");
                }
                sourceSelection = sourceButton.getSelectedPaths();
            }

            if (dest) {
                let destButton = this.$proofCanvas.getButton(dest);
                if (destButton === undefined) {
                    console.error("Dest button not found");
                }
                destinationSelection = destButton.getSelectedPaths();
            }

            var query = {
                kind: kind,
                selection: selection
            };

            if (kind == "click") {
                query.path = source;
            } else if (kind == "dnd") {
                query.source = source;
                if (dest) {
                    query.destination = dest;
                }
            }

            if (sourceSelection) {
                query.sourceSelection = sourceSelection;
            }

            if (destinationSelection) {
                query.destinationSelection = destinationSelection;
            }

            return new Promise(resolve => {
                var result = this.$proofCanvas.proofState.actions(query);
                resolve(result);
            });
        },

        async getDecoratedHTML() {
            //var timeouttest = await this.sleep(5);
            if (!this.clickCache) {
                this.clickCache = await this.getActions("click");
            }
            var actions = this.clickCache;
            var html = this.toHTML();
            var parsed = jQuery.parseHTML(html);
            var prefix = _.first(parsed);
            var domNodes = _.last(parsed);
            if (prefix === domNodes) {
                prefix = null; // no prefix (like "generalize" for goals)
            }

            var mainDiv = $(domNodes);

            // return all actions for a div
            var getDivActions = function(divId) {
                var divActions = [];
                _.each(actions, action => {
                    _.each(action.highlight, hlId => {
                        if (divId == hlId) {
                            divActions.push(action);
                        }
                    });
                });

                return divActions;
            };

            // for all divs id
            var divsWithIds = mainDiv.find("[id]");
            _.each(divsWithIds, div => {
                // get the actions for this div
                var divId = $(div).attr("id");
                var divActions = getDivActions(divId);

                // if there are actions, this div can be highlighted
                if (divActions.length > 0) {
                    $(div).addClass("action");
                    $(div).prop(
                        "title",
                        _.map(divActions, o => o.description).join(" or ")
                    );

                    _.each(divActions, action => {
                        // add a specific class for that action
                        $(div).addClass(
                            "action-" + action.description.toLowerCase()
                        );

                        // now register the specific action event, so we can apply it later
                        this.$proofCanvas.saveActionCode(
                            divId,
                            action.description.toLowerCase(),
                            action.action
                        );
                    });
                }
            });

            let nodesHtml = $(mainDiv).html();
            let prefixHtml = prefix ? $(prefix)[0].outerHTML : "";
            return prefixHtml + nodesHtml;
        },

        // Perform the necessary operations (setting highlights, actions, etc) relative
        // to the current DND context
        async setCurrentDndContext(src, dst) {
            await this.scoutDndActions(src, dst);

            this.clearCurrentDndContext();

            // set the target style on dst if it exits
            if (dst) {
                let div = document.getElementById(dst);
                this.highlightDropDestination(dst);
            }

            let context = _.get(this.dndCache, [src, dst]);
            if (context && context.state == "resolved") {
                this.dndActions = context.dndActions;

                // If there is currently a drop action on current position
                var dropAction = this.getDropAction();
                if (dropAction !== null) {
                    this.unhighlightDrop();
                    if (
                        dropAction.highlight &&
                        dropAction.highlight.length > 0
                    ) {
                        for (let divId of highlight) {
                            this.highlightDropTarget(divId);
                        }
                    } else if (
                        dropAction.action &&
                        dropAction.action.highlight &&
                        dropAction.action.highlight.length > 0
                    ) {
                        for (let divId of dropAction.action.highlight) {
                            this.highlightDropTarget(divId);
                        }
                    }

                    if (dropAction.generalize) {
                        this.highlightGeneralize();
                    } else {
                        // if we get a drop action here, ask the prover for more precision
                        // on the available actions
                        var actions = await this.getActions(
                            "dnd",
                            this.getRootId(),
                            dst ? dst : dropAction.divId
                        );

                        // the current dropAction highlights must be added the "dropTarget" class
                        // highlighs of the other actions must be shown the "dropOver" class, identifying them
                        // as potential drop targets

                        // unhighlight all drop targets
                        _.each(actions, action => {
                            if (
                                _.isEqual(
                                    dropAction.action.action,
                                    action.action
                                )
                            ) {
                                _.each(action.highlight, divId => {
                                    this.highlightDrop(divId);

                                    if (this.intersectWithId(divId)) {
                                        this.highlightDropTarget(divId);
                                    }
                                });
                            }
                        });
                    }
                } else {
                    // else highlight all possible destinations
                    this.$proofCanvas.unhighlight();
                    _.each(this.dndActions, action => {
                        this.$proofCanvas.highlight(action.highlight);
                    });
                }
            }
        },

        clearCurrentDndContext() {
            this.$proofCanvas.unhighlight();
            this.$proofCanvas.unhighlightDrop();
            this.$proofCanvas.unhighlightDropTarget();
            this.$proofCanvas.unhighlightDropDestination();
        },

        // check available drag and drops
        // src and dst can be null
        async scoutDndActions(src, dst) {
            if (!src) src = null;
            if (!dst) dst = null;

            let cache = _.get(this.dndCache, [src, dst]);

            // If we already have a response in the cache, we don't need to interrogate the prover again
            if (!cache) {
                if (!this.dndCache[src]) this.dndCache[src] = {};
                this.dndCache[src][dst] = {
                    state: "resolving"
                };

                var actions = await this.getActions("dnd", src, dst);
                let dndActions = {};
                var toHighlight = [];
                _.each(actions, action => {
                    _.each(action.highlight, id => {
                        toHighlight.push(id);
                    });

                    // action.ui represents our real dnd action
                    var ui = action.ui;
                    dndActions[ui.destination] = action;
                });

                this.dndCache[src][dst].dndActions = dndActions;
                this.dndCache[src][dst].state = "resolved";
            }
        },

        resetDndActions() {
            this.dndScoutState = "not started";
            this.dndActions = {};
            this.dndCache = {};
        },

        cancelDrop() {
            this.$proofCanvas.unhighlight();
        },

        getCurrentZone() {
            throw "Should be redefined !";
        }
    }
};
</script>
