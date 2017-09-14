//          Copyright Brian Schott 2015.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module dfmt.config;

import dfmt.editorconfig;

/// Brace styles
enum BraceStyle
{
    unspecified,
    /// $(LINK https://en.wikipedia.org/wiki/Indent_style#Allman_style)
    allman,
    /// $(LINK https://en.wikipedia.org/wiki/Indent_style#Variant:_1TBS)
    otbs,
    /// $(LINK https://en.wikipedia.org/wiki/Indent_style#Variant:_Stroustrup)
    stroustrup
}

enum TemplateConstraintStyle
{
    unspecified,
    conditional_newline_indent,
    conditional_newline,
    always_newline,
    always_newline_indent
}

/// Configuration options for formatting
struct Config
{
    ///
    OptionalBoolean dfmt_align_switch_statements;
    ///
    BraceStyle dfmt_brace_style;
    ///
    OptionalBoolean dfmt_outdent_attributes;
    ///
    int dfmt_soft_max_line_length = -1;
    ///
    OptionalBoolean dfmt_space_after_cast;
    ///
    OptionalBoolean dfmt_space_after_keywords;
    ///
    OptionalBoolean dfmt_split_operator_at_line_end;
    ///
    OptionalBoolean dfmt_selective_import_space;
    ///
    OptionalBoolean dfmt_compact_labeled_statements;
    ///
    TemplateConstraintStyle dfmt_template_constraint_style;
    ///
    OptionalBoolean dfmt_single_line_statements;
    ///
    OptionalBoolean dfmt_keep_assignment_operator_aligment;

    mixin StandardEditorConfigFields;

    /**
     * Initializes the standard EditorConfig properties with default values that
     * make sense for D code.
     */
    void initializeWithDefaults()
    {
        pattern = "*.d";
        end_of_line = EOL.lf;
        indent_style = IndentStyle.space;
        indent_size = 4;
        tab_width = 4;
        max_line_length = 120;
        dfmt_align_switch_statements = OptionalBoolean.t;
        dfmt_brace_style = BraceStyle.allman;
        dfmt_outdent_attributes = OptionalBoolean.t;
        dfmt_soft_max_line_length = 80;
        dfmt_space_after_cast = OptionalBoolean.t;
        dfmt_space_after_keywords = OptionalBoolean.t;
        dfmt_split_operator_at_line_end = OptionalBoolean.f;
        dfmt_selective_import_space = OptionalBoolean.t;
        dfmt_compact_labeled_statements = OptionalBoolean.t;
        dfmt_template_constraint_style = TemplateConstraintStyle.conditional_newline_indent;
        dfmt_single_line_statements = OptionalBoolean.f;
        dfmt_keep_assignment_operator_aligment = OptionalBoolean.f;
    }

    /**
     * Returns:
     *     true if the configuration is valid
     */
    bool isValid()
    {
        import std.stdio : stderr;

        if (dfmt_soft_max_line_length > max_line_length)
        {
            stderr.writefln("Column hard limit (%d) must be greater than or equal to column soft limit (%d)",
                    max_line_length, dfmt_soft_max_line_length);
            return false;
        }
        return true;
    }
}
