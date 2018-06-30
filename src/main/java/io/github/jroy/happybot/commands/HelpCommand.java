package io.github.jroy.happybot.commands;

import io.github.jroy.happybot.commands.base.CommandBase;
import io.github.jroy.happybot.commands.base.CommandCategory;
import io.github.jroy.happybot.commands.base.CommandEvent;
import io.github.jroy.happybot.commands.base.CommandFactory;

import java.util.List;
import java.util.Map;

public class HelpCommand extends CommandBase {

    private CommandFactory commandFactory;

    public HelpCommand(CommandFactory commandFactory) {
        super("help", null, "Displays command usages.", CommandCategory.GENERAL);
        this.commandFactory = commandFactory;
    }

    @Override
    protected void executeCommand(CommandEvent e) {

        Map<CommandCategory, List<CommandBase>> catBase = commandFactory.getCategorizedCommands();

        e.replySuccess("Help is on the way! :sparkles:");
        StringBuilder builder = new StringBuilder("**happybot** commands:\n\n");

        //Infer Categories

        for (CommandCategory curCat : CommandCategory.values()) {
            builder.append("**__").append(curCat.toString()).append("__**\n\n");
            for (CommandBase base : catBase.get(curCat))
                builder.append("`^").append(base.getName()).append(base.getArguments()==null ? "` - " : " "+base.getArguments()+"` - ").append(base.getHelp()).append(base.getPermissionRole()==null ? " (Public Command)" : " (Requires: " + base.getPermissionRole().getRoleName() + ")").append("\n");
            builder.append("\n");
        }
        e.replyInDm(builder.toString(), unused -> {}, t -> e.replyWarning("Help cannot be sent because you are blocking Direct Messages."));

    }
}