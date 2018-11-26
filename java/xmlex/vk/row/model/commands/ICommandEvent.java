package xmlex.vk.row.model.commands;

public interface ICommandEvent {

    public abstract void ifResult();

    public abstract void ifFault();

    public abstract void ifIoFault();

    public abstract void doFinally();
}
